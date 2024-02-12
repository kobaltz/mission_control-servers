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

If you would like to put the dashboard on something like a Raspberry Pi, you can use the `dark` parameter to
change the dashboard to a dark mode automatically. This will hopefully help provide a "hands off" approach to
setting up the kiosk mode.

You can also create public links with read only permissions.

![image](https://github.com/kobaltz/mission_control-servers/assets/635114/f867bb8a-e372-4e24-9823-7294a6bb4810)


## URL Configuration

### Dark Mode

```html
http://localhost:3000/mission_control-servers/projects?dark=true
```

### Interval

You can also adjust the interval when you have multiple servers on a project. The default setting is 10 seconds
between servers, but this can be adjusted with an URL Parameter. The `interval` value is entered in seconds.

```html
http://localhost:3000/mission_control-servers/projects?interval=10
```

### Combo History

By default, the CPU Usage and Memory Usage Line Chart will be combined, but you can add the URL Parameter `?combo=false` to
toggle this behavior. Default is `true`.

```html
http://localhost:3000/mission_control-servers/projects?combo=false
```

![ScreenShot-2024-02-10-08-55-20](https://github.com/kobaltz/mission_control-servers/assets/635114/6070efe4-0c1a-4e61-b604-b5929a050009)


### Combining URL Parameters

If you need to change multiple settings, you can chain these in the URL Parameters.

```html
http://localhost:3000/mission_control-servers/projects?interval=30&dark=true&combo=false
```


## Protecting the Dashboard

You can protect the dashboard by using a constraint. This will allow you to only allow certain users to access
the dashboard. However, the ingress still needs to be accessible by the servers which are being monitored. In
order to install the script on the servers, you also have to expose the endpoint for the script.

```ruby
Rails.application.routes.draw do
  MissionControl::Servers::RoutingHelpers.add_public_routes_helper(self)

  constraints AdminConstraint do
    mount MissionControl::Servers::Engine => "/mission_control-servers"
  end

end
```
If you want to change the endpoint, you can do so by changing the mount path.

```ruby
Rails.application.routes.draw do
  engine_mount_path = "/dashymcdashface"
  MissionControl::Servers::RoutingHelpers.add_public_routes_helper(self, engine_mount_path)

  constraints AdminConstraint do
    mount MissionControl::Servers::Engine => engine_mount_path
  end

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

## Demo

You can see a demo of the application at [https://dashboard.railsenv.com/](https://dashboard.railsenv.com/)

## Screenshots

Simple Installation

![ScreenShot-2024-02-06-08-50-39](https://github.com/kobaltz/mission_control-servers/assets/635114/78f96ff6-ac14-4798-96a5-59a59eff574c)

View all of your projects

![ScreenShot-2024-02-06-21-34-07](https://github.com/kobaltz/mission_control-servers/assets/635114/6f524e6e-1d4d-4587-9949-f1f3c57724c8)

Detailed Dashboard updates automatically

![ScreenShot-2024-02-10-00-26-22](https://github.com/kobaltz/mission_control-servers/assets/635114/b5c3cc44-b1b2-46ec-8b84-1290358e5ae3)

Dark Mode support added in v0.1.4 (you can set this with a URL Param dark=true)

![ScreenShot-2024-02-10-08-50-24](https://github.com/kobaltz/mission_control-servers/assets/635114/f09652a9-db88-4cf9-a834-e6c85c7e785a)


![ScreenShot-2024-02-10-00-25-48](https://github.com/kobaltz/mission_control-servers/assets/635114/12dc2e6b-b491-42f2-b53e-61e78088e22d)




## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
