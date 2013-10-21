# Config vars and files for redis.
#
# Usage:
#
# class{ 'redis::config':
#   port => "16379",
# }
class redis::config($port) {
  require boxen::config

  $configdir  = "${boxen::config::configdir}/redis"
  $configfile = "${configdir}/redis.conf"
  $datadir    = "${boxen::config::datadir}/redis"
  $executable = "${boxen::config::home}/homebrew/bin/redis-server"
  $logdir     = "${boxen::config::logdir}/redis"
}
