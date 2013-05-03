# Full Redis stack, including service management.
#
# Usage:
#
#     include redis
class redis::darwin {
  include redis::config
  include homebrew

  file { [
    $redis::config::configdir,
    $redis::config::datadir,
    $redis::config::logdir
  ]:
    ensure => directory
  }

  file { "${boxen::config::envdir}/redis.sh":
    content => template('redis/env.sh.erb')
  }

  homebrew::formula { 'redis':
    before => Package['redis'],
  }

  file { '/Library/LaunchDaemons/dev.redis.plist':
    content => template('redis/dev.redis.plist.erb'),
    group   => 'wheel',
    notify  => Service['redis'],
    owner   => 'root'
  }

  file { "${boxen::config::homebrewdir}/var/db/redis":
    ensure  => absent,
    force   => true,
    recurse => true,
    require => Package['redis']
  }
}
