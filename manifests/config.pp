# Config vars and files for redis.
#
# Usage:
#
#     include redis::config
class redis::config {
  require boxen::config

  $configdir  = "${boxen::config::configdir}/redis"
  $configfile = "${configdir}/redis.conf"
  $datadir    = "${boxen::config::datadir}/redis"
  $executable = "${boxen::config::home}/homebrew/bin/redis-server"
  $logdir     = "${boxen::config::logdir}/redis"
  $port       = 16379

  file { [$configdir, $datadir, $logdir]:
    ensure => directory
  }

  file { $configfile:
    content => template('redis/redis.conf.erb'),
    notify  => Service['dev.redis'],
  }

  file { "${boxen::config::homebrewdir}/etc/redis.conf":
    ensure  => absent,
    require => Package['redis']
  }

  file { "${boxen::config::envdir}/redis.sh":
    content => template('redis/env.sh.erb')
  }
}
