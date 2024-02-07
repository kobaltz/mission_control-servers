module MissionControl::Servers
  class Dashboards::ProjectTablesController < ApplicationController
    def show
      @project = Project.includes(:services).find_by(token: params[:project_id])
    end
  end
end
