require "test_helper"

module MissionControl::Servers
  class Dashboards::MemoryHistoriesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @project = mission_control_servers_projects(:one)
    end

    test "should get show" do
      get project_dashboards_memory_history_path(@project.token, hostname: "HOST")
      assert_response :success
    end
  end
end
