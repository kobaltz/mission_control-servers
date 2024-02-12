require "mission_control/servers/version"
require "mission_control/servers/engine"
require "mission_control/servers/configuration"
require "mission_control/servers/routing_helpers"

require "zeitwerk"

loader = Zeitwerk::Loader.new
loader.inflector = Zeitwerk::GemInflector.new(__FILE__)
loader.push_dir(File.expand_path("..", __dir__))
loader.setup

module MissionControl
  module Servers
    class << self
      attr_writer :configuration

      def configuration
        @configuration ||= Configuration.new
      end

      def configure
        yield(configuration) if block_given?
      end
    end
  end
end
