require "importmap-rails"
require "turbo-rails"
require "stimulus-rails"

module MissionControl
  module Servers
    class Engine < ::Rails::Engine
      isolate_namespace MissionControl::Servers

      initializer 'mission_control-servers.middleware.request_tally' do |app|
        app.middleware.use RequestTallyMiddleware
      end

      initializer "mission_control-servers.assets" do |app|
        app.config.assets.paths << root.join("app/javascript")
        app.config.assets.precompile += %w[ mission_control_servers_manifest ]
      end

      initializer "mission_control-servers.importmap", before: "importmap" do |app|
        app.config.importmap.paths << root.join("config/importmap.rb")
        app.config.importmap.cache_sweepers << root.join("app/javascript")
      end
    end
  end
end
