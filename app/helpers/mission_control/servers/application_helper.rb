module MissionControl
  module Servers
    module ApplicationHelper
      def allowed_to_create_project?
        !MissionControl::Servers.configuration.single_project_mode ||
        (MissionControl::Servers.configuration.single_project_mode && !@projects.present?)
      end
    end
  end
end
