# MissionControl::Servers
Don't use this yet. It will be a gem to monitor servers and send the data to Mission Control.

## Installation
Add this line to your application's Gemfile:

```ruby
bundle add "mission_control-servers"
bin/rails mission_control_servers:install:migrations
```


# Usage

Use within your own Rails application or have a separate application to monitor your servers.

You'll make a POST request to the endpoint with the following parameters:

```
endpoint="https://YOUR_APPLICATION/mission_control-servers/projects/YOUR_TOKEN/ingress"; cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1""}'); mem_free=$(free -m | awk '/^Mem:/ {print $3}'); mem_used=$(free -m | awk '/^Mem:/ {print $7}'); disk_free=$(df -h | awk '$NF=="/"{print $4}'); curl -X POST $endpoint -d "service[cpu]=$cpu_usage&service[mem_used]=$mem_free&service[mem_free]=$mem_used&service[disk_free]=$disk_free&service[hostname]=${hostname}"
```

This script should be added to a cron job to run every minute (or however often you want to monitor your servers).

Change `YOUR_APPLICATION` to your application's endpoint and `YOUR_TOKEN` to your project's token.

# Screenshots

These are going to change rapidly as the project is in development.

![ScreenShot-2024-02-05-20-06-07](https://github.com/kobaltz/mission_control-servers/assets/635114/aea31795-80e5-41ae-bad4-8233386dc31f)


## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
