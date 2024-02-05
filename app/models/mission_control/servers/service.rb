module MissionControl::Servers
  class Service < ApplicationRecord
    belongs_to :project
  end
end
