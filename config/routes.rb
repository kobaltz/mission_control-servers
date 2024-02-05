MissionControl::Servers::Engine.routes.draw do
  resources :projects do
    resource :ingress, only: :create
    namespace :dashboards do
      resource :cpu_usage, only: :show
      resource :memory_usage, only: :show
      resource :disk_free, only: :show
      resource :cpu_history, only: :show
    end
  end
  root to: "projects#index"
end
