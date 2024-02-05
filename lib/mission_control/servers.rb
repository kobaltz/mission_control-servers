require "mission_control/servers/version"
require "mission_control/servers/engine"

require "zeitwerk"

loader = Zeitwerk::Loader.new
loader.inflector = Zeitwerk::GemInflector.new(__FILE__)
loader.push_dir(File.expand_path("..", __dir__))
loader.setup

module MissionControl
  module Servers
    # Your code goes here...
  end
end
