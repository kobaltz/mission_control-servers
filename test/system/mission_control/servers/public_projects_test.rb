require "application_system_test_case"

module MissionControl::Servers
  class PublicProjectsTest < ApplicationSystemTestCase
    setup do
      @public_project = mission_control_servers_public_projects(:one)
    end

    test "visiting the index" do
      visit public_projects_url
      assert_selector "h1", text: "Public projects"
    end

    test "should create public project" do
      visit public_projects_url
      click_on "New public project"

      fill_in "Project", with: @public_project.project_id
      fill_in "Token", with: @public_project.token
      click_on "Create Public project"

      assert_text "Public project was successfully created"
      click_on "Back"
    end

    test "should update Public project" do
      visit public_project_url(@public_project)
      click_on "Edit this public project", match: :first

      fill_in "Project", with: @public_project.project_id
      fill_in "Token", with: @public_project.token
      click_on "Update Public project"

      assert_text "Public project was successfully updated"
      click_on "Back"
    end

    test "should destroy Public project" do
      visit public_project_url(@public_project)
      click_on "Destroy this public project", match: :first

      assert_text "Public project was successfully destroyed"
    end
  end
end
