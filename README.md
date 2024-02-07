# MissionControl::Servers
The goal of MissionControl::Servers is to provide a simple monitoring of the resources
on your Ruby on Rails application. You can either use this directly on the projects or create a separate Ruby on
Rails application to mount this in.

## Installation
Add this line to your application's Gemfile:

```ruby
bundle add "mission_control-servers"
bin/rails mission_control_servers:install:migrations
```

Add a mount to your `config/routes.rb`

```ruby
mount MissionControl::Servers::Engine => "/mission_control-servers"
```

## Configuration

Within your application, you can make some configuration changes in how the gem operates. Below are the default
configuration options. You can override these options by creating an initializer file.

For example, if you're wanting to use MissionControl::Servers in a single project, then there is no need to have
the ability to create multiple projects. You can set the `single_project_mode` to true which will hide the ability
to create new projects.

```ruby
# config/initializers/mission_control_servers.rb
MissionControl::Servers.configure do |config|
  config.single_project_mode = true
end
```

## Usage

Create a project. Once you create a project, you can easily copy the script specific to that project.

Install a script which captures:

- Hostname
- CPU Usage
- Memory Usage
- Free Memory
- Free Disk Space

The data will be retained for 7 days automatically. After 7 days, the data will start truncating itself
so that it doesn't take up much disk space within the database.

## Protecting the Dashboard

You can protect the dashboard by using a constraint. This will allow you to only allow certain users to access
the dashboard. However, the ingress still needs to be accessible by the servers which are being monitored.

```ruby
Rails.application.routes.draw do
  constraints AdminConstraint do
    mount MissionControl::Servers::Engine => "/mission_control-servers"
  end
  post '/mission_control-servers/projects/:project_id/ingress', to: 'mission_control/servers/ingresses#create'
end
```

In this example, we have directly given a path to the ingress, but locked down everything else to the AdminConstraint.
The AdminConstraint takes in the request and calls the `matches?` method. If the method returns true,
then the routes will be defined for that request.

```ruby
class AdminConstraint
  def self.matches?(request)
    true
  end
end
```

## Screenshots

Simple Installation

![ScreenShot-2024-02-06-08-50-39](https://github.com/kobaltz/mission_control-servers/assets/635114/78f96ff6-ac14-4798-96a5-59a59eff574c)

View all of your projects

![ScreenShot-2024-02-06-21-34-07](https://github.com/kobaltz/mission_control-servers/assets/635114/6f524e6e-1d4d-4587-9949-f1f3c57724c8)

Detailed Dashboard updates automatically

![ScreenShot-2024-02-05-20-06-07](https://github.com/kobaltz/mission_control-servers/assets/635114/aea31795-80e5-41ae-bad4-8233386dc31f)

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
