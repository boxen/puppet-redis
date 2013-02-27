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
  $port       = 6379
}
