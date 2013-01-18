# Configure redis service plist and run service.
#
# Usage:
#
#     include redis::service
class redis::service {
  require redis::config

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
    require => Package['redis']
  }

  service { 'dev.redis':
    ensure  => running
  }

  service { 'com.boxen.redis': # replaced by dev.redis
    before => Service['dev.redis'],
    enable => false
  }
}
