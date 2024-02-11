module MissionControl::Servers
  class Dashboards::ProjectTablesController < ApplicationController
    def show
      @project = Project.includes(:services).find_by(token: params[:project_id])
      @service_settings = @project.service_settings
    end
  end
end
