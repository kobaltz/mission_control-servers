module MissionControl::Servers
  class ServiceSetting < ApplicationRecord
    belongs_to :project
    before_create :set_request_hostname

    private

    def set_request_hostname
      self.request_hostname ||= hostname
    end
  end
end
