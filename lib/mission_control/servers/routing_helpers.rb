module MissionControl
  module Servers
    module RoutingHelpers
      def self.add_public_routes_helper(drawer, engine_mount_path="/mission_control-servers")
        drawer.instance_eval do
          get "#{engine_mount_path}/projects/:project_id/dashboards/project_table", to: "mission_control/servers/dashboards/project_tables#show"
          get "#{engine_mount_path}/projects/:project_id/dashboards/cpu_usage", to: "mission_control/servers/dashboards/cpu_usages#show"
          get "#{engine_mount_path}/projects/:project_id/dashboards/memory_usage", to: "mission_control/servers/dashboards/memory_usages#show"
          get "#{engine_mount_path}/projects/:project_id/dashboards/disk_free", to: "mission_control/servers/dashboards/disk_frees#show"
          get "#{engine_mount_path}/projects/:project_id/dashboards/last_seen", to: "mission_control/servers/dashboards/last_seens#show"
          get "#{engine_mount_path}/projects/:project_id/dashboards/cpu_history", to: "mission_control/servers/dashboards/cpu_histories#show"
          get "#{engine_mount_path}/projects/:project_id/dashboards/memory_history", to: "mission_control/servers/dashboards/memory_histories#show"
          get "#{engine_mount_path}/projects/:project_id/dashboards/combo_history", to: "mission_control/servers/dashboards/combo_histories#show"
          get "#{engine_mount_path}/projects/:project_id/dashboards/request_total", to: "mission_control/servers/dashboards/request_totals#show"
          get "#{engine_mount_path}/projects/:project_id/dashboards/request_chart", to: "mission_control/servers/dashboards/request_charts#show"
          get "#{engine_mount_path}/projects/:project_id/public_projects/new", to: "mission_control/servers/public_projects#new", as: :new_project_public_project
          get "#{engine_mount_path}/projects/:project_id/public_projects/:id", to: "mission_control/servers/public_projects#show"
          get "#{engine_mount_path}/projects/:project_id/script", to: "mission_control/servers/scripts#show"
          post "#{engine_mount_path}/projects/:project_id/ingress", to: "mission_control/servers/ingresses#create"
        end
      end
    end
  end
end
