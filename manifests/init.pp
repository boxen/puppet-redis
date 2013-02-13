# Full Redis stack, including service management.
#
# Usage:
#
#     include redis
class redis {
  include homebrew
  include redis::config

  file { [
    $redis::config::configdir,
    $redis::config::datadir,
    $redis::config::logdir
  ]:
    ensure => directory
  }

  file { $redis::config::configfile:
    content => template('redis/redis.conf.erb'),
    notify  => Service['dev.redis'],
  }

  file { "${boxen::config::homebrewdir}/etc/redis.conf":
    ensure  => absent,
    require => Package['boxen/brews/redis']
  }

  file { "${boxen::config::envdir}/redis.sh":
    content => template('redis/env.sh.erb')
  }

  homebrew::formula { 'redis':
    before => Package['boxen/brews/redis'],
  }

  package { 'boxen/brews/redis':
    ensure => '2.6.9-boxen1',
    notify => Service['dev.redis'],
  }

  file { '/Library/LaunchDaemons/dev.redis.plist':
    content => template('redis/dev.redis.plist.erb'),
    group   => 'wheel',
    notify  => Service['dev.redis'],
    owner   => 'root'
  }

  file { "${boxen::config::homebrewdir}/var/db/redis":
    ensure  => absent,
    force   => true,
    recurse => true,
    require => Package['boxen/brews/redis']
  }

  service { 'dev.redis':
    ensure  => running
  }

  service { 'com.boxen.redis': # replaced by dev.redis
    before => Service['dev.redis'],
    enable => false
  }
}
