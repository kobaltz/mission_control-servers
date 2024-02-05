module MissionControl::Servers
  class Dashboards::CpuHistoriesController < ApplicationController
    def show
      @project = MissionControl::Servers::Project.find_by(token: params[:project_id])
      @hostname = params[:hostname]
      services = @project.services.where(hostname: @hostname).ordered
      @cpu_history_data = MissionControl::Servers::Service.cpu_usage_history(services)
    end
  end
end
