module MissionControl::Servers
  class ScriptsController < ApplicationController
    before_action :set_project

    def show
      head :not_found and return unless @project
      response.content_type = 'text/plain'

      # Render the script directly or from a file
      render plain: script_content
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_project
        @project = Project.find_by(token: params[:project_id])
      end

      def script_content
        <<~SCRIPT
        cat <<'EOF' > metrics.sh
        #!/bin/bash

        endpoint="#{project_ingress_url(@project.token)}"
        cpu_usage=$(
          top -bn1 | \
          grep "Cpu(s)" | \
          sed "s/.*, *\\([0-9.]*\\)%* id.*/\\1/" | \
          awk '{print 100 - $1}'
        )
        mem_used=$(free -m | awk '/^Mem:/ {print $3}')
        mem_free=$(free -m | awk '/^Mem:/ {print $7}')
        disk_free=$(df -h | awk '\$NF=="/"{print $4}')
        hostname=$(hostname)

        data="service[cpu]=$cpu_usage"
        data+="&service[mem_used]=$mem_used"
        data+="&service[mem_free]=$mem_free"
        data+="&service[disk_free]=$disk_free"
        data+="&service[hostname]=$hostname"

        curl -X POST $endpoint -d $data
        EOF

        chmod +x metrics.sh

        cron_job="* * * * * $(pwd)/metrics.sh"
        (crontab -l 2>/dev/null | grep -v -F "$cron_job"; echo "$cron_job") | crontab -
        SCRIPT
      end
  end
end
