require "test_helper"

module MissionControl::Servers
  class Dashboards::DiskFreesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @project = mission_control_servers_projects(:one)
    end

    test "should get show" do
      get project_dashboards_disk_free_path(@project.token, hostname: "HOST")
      assert_response :success
    end
  end
end
