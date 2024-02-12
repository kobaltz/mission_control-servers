MissionControl::Servers::Engine.routes.draw do
  resources :projects do
    resources :public_projects, except: [:edit, :update]
    resources :service_settings, only: [:edit, :update]
    resource :ingress, only: :create
    resource :script, only: :show
    namespace :dashboards do
      resource :project_table, only: :show
      resource :cpu_usage, only: :show
      resource :memory_usage, only: :show
      resource :disk_free, only: :show
      resource :last_seen, only: :show
      resource :cpu_history, only: :show
      resource :memory_history, only: :show
      resource :combo_history, only: :show
    end
  end
  root to: "projects#index"
end
