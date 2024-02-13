task :tailwind_engine_watch do
  require "tailwindcss-rails"
  # NOTE: tailwindcss-rails is an engine
  system "#{Tailwindcss::Engine.root.join("exe/tailwindcss")} \
         -i #{MissionControl::Servers::Engine.root.join("app/assets/stylesheets/mission_control/servers/application.tailwind.css")} \
         -o #{MissionControl::Servers::Engine.root.join("app/assets/builds/mission_control_servers_application.css")} \
         -c #{MissionControl::Servers::Engine.root.join("config/tailwind.config.js")} \
         -w"
end
