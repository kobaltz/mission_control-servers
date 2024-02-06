Rails.application.routes.draw do
  constraints AdminConstraint do
    mount MissionControl::Servers::Engine => "/mission_control-servers"
  end
  post '/mission_control-servers/projects/:project_id/ingress', to: 'mission_control/servers/ingresses#create'
end
