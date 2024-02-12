module MissionControl::Servers
  class PublicProjectsController < ApplicationController
    before_action :set_project

    # GET /public_projects
    def index
      @public_projects = @project.public_projects.all
    end

    # GET /public_projects/1
    def show
      @project.public_projects.find_by!(token: params[:id])

      hostnames = @project.services.pluck(:hostname).uniq
      @service_settings = @project.service_settings.where(hostname: hostnames)
      @services = if params[:hostname]
        @project.services.where(hostname: params[:hostname]).group_by(&:hostname)
      else
        @project.services.group_by(&:hostname)
      end
    end

    # GET /public_projects/new
    def new
      @public_project = @project.public_projects.new
    end

    # POST /public_projects
    def create
      @public_project = @project.public_projects.new(public_project_params)

      if @public_project.save
        redirect_to project_public_projects_path(@project), notice: "Public project was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    # DELETE /public_projects/1
    def destroy
      @public_project = @project.public_projects.find(params[:id])
      @public_project.destroy!
      redirect_to project_public_projects_path(@project), notice: "Public project was successfully destroyed.", status: :see_other
    end

    private
      def set_project
        @project = Project.find(params[:project_id])
      end

      # Only allow a list of trusted parameters through.
      def public_project_params
        params.require(:public_project).permit(:name)
      end
  end
end
