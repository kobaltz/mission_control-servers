module MissionControl::Servers
  class Dashboards::MemoryHistoriesController < ApplicationController
    def show
      @project = MissionControl::Servers::Project.find_by(token: params[:project_id])
      @hostname = params[:hostname]
      services = @project.services.where(hostname: @hostname).ordered
      @memory_history_data = MissionControl::Servers::Service.memory_usage_history(services)
    end
  end
end
