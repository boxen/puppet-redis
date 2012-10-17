# Configure redis service plist and run service.
#
# Usage:
#
#     include redis::service
class redis::service {
  require redis::config

  file { '/Library/LaunchDaemons/com.boxen.redis.plist':
    content => template('redis/com.boxen.redis.plist.erb'),
    group   => 'wheel',
    notify  => Service['com.boxen.redis'],
    owner   => 'root'
  }

  file { "${boxen::config::homebrewdir}/var/db/redis":
    ensure  => absent,
    force   => true,
    recurse => true,
    require => Package['redis']
  }

  service { 'com.boxen.redis':
    ensure  => running
  }
}
