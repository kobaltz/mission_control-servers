Rails.application.routes.draw do
  MissionControl::Servers::RoutingHelpers.add_public_routes_helper(self)
  constraints AdminConstraint do
    mount MissionControl::Servers::Engine => "/mission_control-servers"
  end
  root to: "mission_control/servers/projects#index"
end
