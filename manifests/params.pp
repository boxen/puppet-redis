# Internal: default values

class redis::params {

  case $::operatingsystem {
    Darwin: {
      include boxen::config

      $configdir   = "${boxen::config::configdir}/redis"
      $datadir     = "${boxen::config::datadir}/redis"
      $logdir      = "${boxen::config::logdir}/redis"
      $host        = '127.0.0.1'
      $port        = '16379'
      $pidfile     = "${datadir}/pid"

      $executable  = "${boxen::config::home}/homebrew/bin/redis-server"

      $package     = 'boxen/brews/redis'
      $version     = '2.6.9-boxen1'

      $servicename = 'dev.redis'
    }

    Ubuntu: {
      $configdir   = '/etc/redis'
      $datadir     = '/data/redis'
      $logdir      = '/var/log/redis'
      $host        = $::ipaddress
      $port        = '6379'
      $pidfile     = '/run/redis.pid'

      $executable  = undef # only used on Darwin

      $package     = 'redis-server'
      $version     = 'installed'

      $servicename = 'redis-server'

    }

    default: {
      fail('Unsupported operating system!')
    }
  }

  $ensure = present
  $enable = true

}
