module MissionControl
  module Servers
    class Configuration

      attr_accessor :single_project_mode

      def initialize
        @single_project_mode = true
      end

    end
  end
end
