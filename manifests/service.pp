class redis::service {
  file { '/Library/LaunchDaemons/com.setup.redis.plist':
    content => template('redis/com.setup.redis.plist.erb'),
    group   => 'wheel',
    notify  => Service['com.setup.redis'],
    owner   => 'root'
  }

  file { "${github::config::homebrewdir}/var/db/redis":
    ensure  => absent,
    force   => true,
    recurse => true,
    require => Package['redis']
  }

  service { 'com.setup.redis':
    ensure  => running,
    require => Package['redis']
  }
}
