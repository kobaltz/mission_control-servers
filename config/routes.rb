MissionControl::Servers::Engine.routes.draw do
  resources :projects do
    resource :ingress, only: :create
  end
  root to: "projects#index"
end
