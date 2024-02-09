require "test_helper"

class MissionControl::ServersTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert MissionControl::Servers::VERSION
  end

  test "single_project_mode enabled" do
    MissionControl::Servers.configure do |config|
      config.single_project_mode = true
    end
    assert MissionControl::Servers.configuration.single_project_mode
  end

  test "single_project_mode disabled" do
    MissionControl::Servers.configure do |config|
      config.single_project_mode = false
    end
    assert_not MissionControl::Servers.configuration.single_project_mode
  end
end
