require "test_helper"

module MissionControl::Servers
  class Dashboards::ComboHistoriesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @project = mission_control_servers_projects(:one)
    end

    test "should get show" do
      get project_dashboards_combo_history_path(@project.token)
      assert_response :success
    end
  end
end
