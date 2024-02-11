module MissionControl::Servers
  class IngressesController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_project

    def create
      ingress = @project.services.new(ingress_params)

      if ingress.save
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
  end
end
