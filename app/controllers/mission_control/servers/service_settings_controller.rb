module MissionControl::Servers
  class ServiceSettingsController < ApplicationController
    def edit
      @project = Project.find(params[:project_id])
      @service_setting = @project.service_settings.find_or_initialize_by(hostname: params[:id])
      @service_setting.label = params[:id] if @service_setting.new_record?
      @service_setting.save # To limit having to have a create action
      @requests = @project.requests.select(:hostname).distinct.pluck(:hostname)
    end

    def update
      @project = Project.find(params[:project_id])
      @service_setting = @project.service_settings.find_by(hostname)
      @service_setting.update(label)
      redirect_to projects_path, notice: "Updated Service Settings."
    end

    private

    def hostname
      params.require(:service_setting).permit(:hostname)
    end

    def label
      params.require(:service_setting).permit(:label, :hostname, :request_hostname)
    end
  end
end
