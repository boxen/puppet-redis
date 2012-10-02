class redis::config {
  require github::config

  $configdir  = "${github::config::configdir}/redis"
  $configfile = "${configdir}/redis.conf"
  $datadir    = "${github::config::datadir}/redis"
  $executable = "${github::config::home}/homebrew/bin/redis-server"
  $logdir     = "${github::config::logdir}/redis"
  $port       = 16379

  file { [$configdir, $datadir, $logdir]:
    ensure => directory
  }

  file { $configfile:
    content => template('redis/redis.conf.erb'),
    notify  => Service['com.setup.redis'],
  }

  file { "${github::config::homebrewdir}/etc/redis.conf":
    ensure  => absent,
    require => Package['redis']
  }

  file { "${github::config::envdir}/redis.sh":
    content => template('redis/env.sh.erb'),
    require => File[$github::config::envdir]
  }
}
