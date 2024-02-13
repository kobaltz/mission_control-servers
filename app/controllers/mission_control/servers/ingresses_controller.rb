module MissionControl::Servers
  class IngressesController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_project

    def create
      ingress = @project.services.new(ingress_params)
      request = @project.requests.new(tally_params)
      if ingress.save && request.save
        head :ok
      else
        head :unprocessable_entity
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_project
        @project = Project.find_by!(token: params[:project_id])
      end

      def ingress_params
        params.require(:service).permit(:hostname, :cpu, :mem_used, :mem_free, :disk_free)
      end

      def tally_params
        params.require(:tally).permit(:hostname, :'sum_2xx', :'sum_3xx', :'sum_4xx', :'sum_5xx', :unknown)
      end
  end
end
