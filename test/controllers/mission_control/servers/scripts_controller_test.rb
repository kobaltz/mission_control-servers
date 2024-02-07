require "test_helper"

module MissionControl::Servers
  class ScriptsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @project = mission_control_servers_projects(:one)
    end

    test "should show script for project" do
      get project_script_url(project_id: @project.token), as: :text
      assert_response :success
      assert_match @project.token, @response.body
      assert_match "#!/bin/bash", @response.body
      assert_match "curl -X POST $endpoint -d $data", @response.body
    end

    test "should handle non-existing project" do
      get project_script_url(project_id: 'non-existing'), as: :text
      # Assuming you handle non-existing projects with a 404 or similar response
      assert_response :not_found
    end

    private

    def project_ingress_url(token)
      # Mock the helper method used in the controller to generate the URL
      # This needs to match the actual implementation or be adjusted to your app's routing
      "http://example.com/ingress/#{token}"
    end
  end
end
