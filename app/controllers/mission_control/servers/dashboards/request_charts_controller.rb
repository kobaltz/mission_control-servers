module MissionControl::Servers
  class Dashboards::RequestChartsController < ApplicationController
    def show
      @project = MissionControl::Servers::Project.find_by(token: params[:project_id])
      @hostname = params[:hostname]
      recent_requests = @project.requests.recent_totals(@project, @hostname)
      @summary_hash = {
        sum_2xx: recent_requests.sum(:sum_2xx).to_i,
        sum_3xx: recent_requests.sum(:sum_3xx).to_i,
        sum_4xx: recent_requests.sum(:sum_4xx).to_i,
        sum_5xx: recent_requests.sum(:sum_5xx).to_i,
        unknown: recent_requests.sum(:unknown).to_i
      }
    end
  end
end
