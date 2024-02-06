# MissionControl::Servers
Don't use this yet as it is under rapid development. The goal of MissionControl::Servers is to provide a simple monitoring of the resources
on your Ruby on Rails application. You can either use this directly on the projects or create a separate Ruby on Rails application to mount this in.

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
# Usage

Create a project. Once you create a project, you can easily copy the script specific to that project.

Install a script which captures:

- Hostname
- CPU Usage
- Memory Usage
- Free Memory
- Free Disk Space

The data will be retained for 7 days automatically. After 7 days, the data will start truncating itself so that it doesn't take
up much disk space within the database.

# Screenshots

Simple Installation

![ScreenShot-2024-02-06-08-50-39](https://github.com/kobaltz/mission_control-servers/assets/635114/78f96ff6-ac14-4798-96a5-59a59eff574c)

View all of your projects

![ScreenShot-2024-02-06-00-26-37](https://github.com/kobaltz/mission_control-servers/assets/635114/b7e37682-34ff-404a-a158-92e310496696)

Detailed Dashboard updates automatically

![ScreenShot-2024-02-05-20-06-07](https://github.com/kobaltz/mission_control-servers/assets/635114/aea31795-80e5-41ae-bad4-8233386dc31f)


## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
