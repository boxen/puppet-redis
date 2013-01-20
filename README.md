# Redis Puppet Module for Boxen

Requires the following boxen modules:

* [boxen](https://github.com/boxen/puppet-boxen)
* [homebrew](https://github.com/boxen/puppet-homebrew)

## Usage

```puppet
include redis
```

### Environment

Once installed, you can access the following variables in your environment, projects, etc:

* BOXEN_REDIS_PORT: the configured redis port
* BOXEN_REDIS_URL: the URL for redis, including localhost & port

#### Hubot

For [hubot](https://github.com/github/hubot) development, particularly using the [redis-brain](https://github.com/github/hubot-scripts/blob/master/src/scripts/redis-brain.coffee), you'll need the following:

```shell
export REDISTOGO_URL=$BOXEN_REDIS_URL
```

#### Ruby

```ruby
$redis = Redis.new(:host => '127.0.0.1', :port => ENV['BOXEN_REDIS_PORT'] || '6379'
```
