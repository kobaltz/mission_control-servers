module MissionControl::Servers
  class Dashboards::RequestTotalsController < ApplicationController
    def show
      @project = Project.find_by(token: params[:project_id])
      @hostname = params[:hostname]
      recent_requests = @project.requests.recent_totals(@project, @hostname)
      @total_sum = recent_requests.sum(:sum_2xx).to_i +
        recent_requests.sum(:sum_3xx).to_i +
        recent_requests.sum(:sum_4xx).to_i +
        recent_requests.sum(:sum_5xx).to_i +
        recent_requests.sum(:unknown).to_i

    end
  end
end
