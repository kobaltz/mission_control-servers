module MissionControl::Servers
  class Request < ApplicationRecord
    belongs_to :project
    after_create :trim_old_requests

    class << self
      def recent_totals(project, hostname)
        recent_requests(project, hostname)
      end

      def recent_requests(project, hostname)
        where(
          hostname: [service_setting(project, hostname), hostname].compact.uniq,
          created_at: 1.minute.ago..
        )
      end

      def service_setting(project, hostname)
        project.service_settings.find_by(hostname: hostname)&.request_hostname
      end
    end

    private

      def trim_old_requests
        project.requests.where(hostname: hostname).where(created_at: ..1.hour.ago).delete_all
      end
  end
end
