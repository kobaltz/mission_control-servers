require_relative "lib/mission_control/servers/version"

Gem::Specification.new do |spec|
  spec.name        = "mission_control-servers"
  spec.version     = MissionControl::Servers::VERSION
  spec.authors     = ["Dave Kimura"]
  spec.email       = ["dave@k-innovations.net"]
  spec.homepage    = "https://github.com/kobaltz/misson_control-servers"
  spec.summary     = "Dashboard for managing servers."
  spec.description = "Dashboard for managing servers."
  spec.license     = "MIT"

  spec.post_install_message = <<~MESSAGE
    MissionControl::Servers requires additional setup. Please run the following
    command to install the necessary files:

    bin/rails mission_control_servers:install:migrations
  MESSAGE

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/kobaltz/mission_control-servers"
  spec.metadata["changelog_uri"] = "https://github.com/kobaltz/mission_control-servers"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.0"
  spec.add_dependency 'importmap-rails'
  spec.add_dependency 'turbo-rails'
  spec.add_dependency 'stimulus-rails'
  spec.add_dependency "tailwindcss-rails"
  spec.add_development_dependency "simplecov"
end
