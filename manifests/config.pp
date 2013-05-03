# Config vars and files for redis.
#
# Usage:
#
#     include redis::config
class redis::config {

  case $::osfamily {
    'Debian': {
      $configdir    = '/etc'
      $datadir    = '/var/lib/redis'
      $port       = '6379'
      $logdir     = '/var/log/redis'
      $package_name = 'redis-server'
      $service_name = 'redis-server'
      $version      = 'installed'
    }
    'Darwin': {
      include boxen::config
      $configdir  = "${boxen::config::configdir}/redis"
      $datadir    = "${boxen::config::datadir}/redis"
      $executable = "${boxen::config::home}/homebrew/bin/redis-server"
      $logdir     = "${boxen::config::logdir}/redis"
      $port       = '16379'
      $package_name = 'boxen/brews/redis'
      $service_name = 'dev.redis'
      $version       = '2.6.9-boxen1'
    }
  }
}
