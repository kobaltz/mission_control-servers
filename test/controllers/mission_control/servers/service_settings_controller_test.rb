require "test_helper"

module MissionControl::Servers
  class ServiceSettingsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @project = mission_control_servers_projects(:one)
      @service = @project.services.first
    end

    test "should get edit" do
      get edit_project_service_setting_path(@project, id: @service.hostname)
      assert_response :success
    end

    test "should patch update" do
      patch project_service_setting_path(@project, id: @service.hostname), params: { service_setting: { label: "example", request_hostname: "example" }}
      assert_response :redirect
    end
  end
end
