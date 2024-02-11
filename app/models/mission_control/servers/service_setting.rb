module MissionControl::Servers
  class ServiceSetting < ApplicationRecord
    belongs_to :project
  end
end
