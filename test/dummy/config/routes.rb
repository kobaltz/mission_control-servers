Rails.application.routes.draw do
  mount MissionControl::Servers::Engine => "/mission_control-servers"
end
