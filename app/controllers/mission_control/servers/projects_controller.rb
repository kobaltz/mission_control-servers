module MissionControl::Servers
  class ProjectsController < ApplicationController
    before_action :set_project, only: %i[ show edit update destroy ]
    before_action :verify_single_project_mode, only: %i[ new create ]

    # GET /projects
    def index
      @projects = Project.all
    end

    # GET /projects/1
    def show
      @services = if params[:hostname]
        @project.services.where(hostname: params[:hostname]).group_by(&:hostname)
      else
        @project.services.group_by(&:hostname)
      end
    end

    # GET /projects/new
    def new
      @project = Project.new
    end

    # GET /projects/1/edit
    def edit
    end

    # POST /projects
    def create
      @project = Project.new(project_params)

      if @project.save
        redirect_to @project, notice: "Project was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /projects/1
    def update
      if @project.update(project_params)
        redirect_to @project, notice: "Project was successfully updated.", status: :see_other
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /projects/1
    def destroy
      if params[:hostname]
        @project.services.where(hostname: params[:hostname]).delete_all
        redirect_to project_dashboards_project_table_path(@project.token), notice: "Service was successfully destroyed.", status: :see_other
      else
        @project.destroy!
        redirect_to projects_url, notice: "Project was successfully destroyed.", status: :see_other
      end
    end

    private
      def verify_single_project_mode
        if MissionControl::Servers.configuration.single_project_mode && Project.any?
          redirect_to projects_url, notice: "Single project mode is enabled. You can only have one project at a time."
        end
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_project
        @project = Project.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def project_params
        params.require(:project).permit(:title, :token)
      end
  end
end
