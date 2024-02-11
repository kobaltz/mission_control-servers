module MissionControl::Servers
  class ScriptsController < ApplicationController
    before_action :set_project

    def show
      response.content_type = 'text/plain'

      # Render the script directly or from a file
      render plain: script_content
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_project
        @project = Project.find_by!(token: params[:project_id])
      end

      def script_content
        <<~SCRIPT
        if [ "$(id -u)" -eq 0 ]; then
          SUDO=""
        else
          if command -v sudo > /dev/null; then
            SUDO="sudo"
          else
            echo "Script needs to be run as root or with sudo installed."
            exit 1
          fi
        fi

        if command -v apt-get > /dev/null; then
          $SUDO apt-get update
          $SUDO apt-get install -y curl cron
        elif command -v yum > /dev/null; then
          $SUDO yum install -y curl cronie
        elif command -v zypper > /dev/null; then
          $SUDO zypper install -y curl cron
        else
          echo "Unsupported package manager. Please install curl and cron manually."
          exit 1
        fi

        cat <<'EOF' > metrics.sh
        #!/bin/bash

        DEBUG=0
        if [[ "$1" == "--debug" ]]; then
          DEBUG=1
        fi

        debug() {
          if [[ $DEBUG -eq 1 ]]; then
            echo "Debug: $1"
          fi
        }

        endpoint="#{project_ingress_url(@project.token)}"
        cpu_usage=$(vmstat 1 5 | awk 'NR==4 {print 100 - $15}')
        mem_used=$(free -m | awk '/^Mem:/ {print $3}')
        mem_free=$(free -m | awk '/^Mem:/ {print $7}')
        disk_free=$(df -h | awk '$NF=="/"{print $4}')
        hostname=$(hostname)

        # Debug outputs
        debug "CPU Usage: $cpu_usage"
        debug "Memory Used: $mem_used MB"
        debug "Memory Free: $mem_free MB"
        debug "Disk Free: $disk_free"
        debug "Hostname: $hostname"

        data=$(printf "service[cpu]=%s&service[mem_used]=%s&service[mem_free]=%s&service[disk_free]=%s&service[hostname]=%s" \
          "$cpu_usage" "$mem_used" "$mem_free" "$disk_free" "$hostname")

        debug "Data being sent: $data"

        if [[ $DEBUG -eq 1 ]]; then
          curl -v -X POST "$endpoint" -d "$data"
        else
          curl -X POST "$endpoint" -d "$data"
        fi
        EOF

        chmod +x metrics.sh

        cron_job="* * * * * $(pwd)/metrics.sh"
        (crontab -l 2>/dev/null | grep -v -F "$cron_job"; echo "$cron_job") | crontab -
        echo "Sending first request to the server..."
        bash $(pwd)/metrics.sh
        echo
        echo "████████████████████████████████████████████████████████████████████████████"
        echo "█                                                                          █"
        echo "█  ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ███████╗██████╗   █"
        echo "█  ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔════╝██╔══██╗  █"
        echo "█  ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     █████╗  ██║  ██║  █"
        echo "█  ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══╝  ██║  ██║  █"
        echo "█  ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗███████╗██████╔╝  █"
        echo "█  ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═════╝   █"
        echo "█                                                                          █"
        echo "█        Metrics script installed and scheduled to run every minute.       █"
        echo "█          This script is idempotent and can be run multiple times.        █"
        echo "█                                                                          █"
        echo "█            To uninstall, remove the cron job (crontab -e) and            █"
        echo "█                      delete the metrics.sh file.                         █"
        echo "█                                                                          █"
        echo "████████████████████████████████████████████████████████████████████████████"

        SCRIPT
      end
  end
end
