require "test_helper"

module MissionControl::Servers
  class PublicProjectsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @project = mission_control_servers_projects(:one)
      @public_project = mission_control_servers_public_projects(:one)
    end

    test "should get index" do
      get project_public_projects_url(@project)
      assert_response :success
    end

    test "should get new" do
      get new_project_public_project_url(@project)
      assert_response :success
    end

    test "should create public_project" do
      assert_difference("PublicProject.count") do
        post project_public_projects_url(@project), params: { public_project: { project_id: @public_project.project_id, token: @public_project.token } }
      end

      assert_redirected_to project_public_projects_url(@project)
    end

    test "should show public_project" do
      get project_public_project_url(@project, @public_project.token)
      assert_response :success
    end

    test "should destroy public_project" do
      assert_difference("PublicProject.count", -1) do
        delete project_public_project_url(@project, @public_project)
      end

      assert_redirected_to project_public_projects_url(@project)
    end
  end
end
