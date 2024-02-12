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

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.

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
