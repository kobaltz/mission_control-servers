module MissionControl::Servers
  class Dashboards::DiskFreesController < ApplicationController
    def show
      @project = MissionControl::Servers::Project.find_by(token: params[:project_id])
      @hostname = params[:hostname]
      @service = @project.services.where(hostname: @hostname).last
    end
  end
end
