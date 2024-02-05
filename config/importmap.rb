pin "application-mcs", to: "mission_control/servers/application.js", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from MissionControl::Servers::Engine.root.join("app/javascript/mission_control/servers/controllers"), under: "controllers", to: "mission_control/servers/controllers"
