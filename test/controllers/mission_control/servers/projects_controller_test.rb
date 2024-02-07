require "test_helper"

module MissionControl::Servers
  class ProjectsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @project = mission_control_servers_projects(:one)
    end

    test "should get index" do
      get projects_url
      assert_response :success
    end

    test "should not get new" do
      get new_project_url
      assert_redirected_to projects_url
    end

    test "should get new" do
      MissionControl::Servers::Project.destroy_all
      get new_project_url
      assert_response :success
    end

    test "should not create project" do
      assert_no_difference("Project.count") do
        post projects_url, params: { project: { title: @project.title, token: @project.token } }
      end

      assert_redirected_to projects_url
    end

    test "should create project when none exists" do
      MissionControl::Servers::Project.destroy_all
      assert_difference("Project.count") do
        post projects_url, params: { project: { title: @project.title, token: @project.token } }
      end

      assert_redirected_to project_url(Project.last)
    end

    test "should show project" do
      get project_url(@project)
      assert_response :success
    end

    test "should get edit" do
      get edit_project_url(@project)
      assert_response :success
    end

    test "should update project" do
      patch project_url(@project), params: { project: { title: @project.title, token: @project.token } }
      assert_redirected_to project_url(@project)
    end

    test "should destroy project" do
      assert_difference("Project.count", -1) do
        delete project_url(@project)
      end

      assert_redirected_to projects_url
    end
  end
end
