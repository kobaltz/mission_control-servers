module MissionControl::Servers
  class Dashboards::ComboHistoriesController < ApplicationController
    def show
      @project = MissionControl::Servers::Project.find_by(token: params[:project_id])
      @hostname = params[:hostname]
      services = @project.services.where(hostname: @hostname).ordered
      @combo_history_data = MissionControl::Servers::Service.combo_history(services)
    end
  end
end
