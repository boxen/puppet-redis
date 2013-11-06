# Internal: default values

class redis::params {

  case $::operatingsystem {
    Darwin: {
      include boxen::config

      $configdir   = "${boxen::config::configdir}/redis"
      $dir         = "${boxen::config::datadir}/redis"
      $logdir      = "${boxen::config::logdir}/redis"
      $bind        = '127.0.0.1'
      $port        = 16379
      $pidfile     = "${datadir}/pid"

      $executable  = "${boxen::config::home}/homebrew/bin/redis-server"

      $package     = 'boxen/brews/redis'
      $version     = '2.6.9-boxen1'

      $servicename = 'dev.redis'
      $enable      = true
    }

    Ubuntu: {
      $configdir   = '/etc/redis'
      $dir         = '/data/redis'
      $logdir      = '/var/log/redis'
      $bind        = $::ipaddress
      $port        = 6379
      $pidfile     = '/run/redis.pid'

      $executable  = undef # only used on Darwin

      $package     = 'redis-server'
      $version     = 'installed'

      $servicename = 'redis-server'
      $enable      = true
    }

    default: {
      fail("Unsupported operating system!")
    }
  }

  $default_config = {
    'daemonize'                   => 'no',
    'pidfile'                     => $pidfile,
    'bind'                        => $bind,
    'port'                        => $port,
    'timeout'                     => 0,

    'loglevel'                    => 'verbose',
    'logfile'                     => "${logdir}/redis.log",

    'databases'                   => 16,

    'dbfilename'                  => 'dump.rdb',
    'rdbcompression'              => 'yes',
    'dir'                         => $dir,

    'appendonly'                  => 'no',
    'appendfsync'                 => 'everysec',
    'no-appendfsync-on-rewrite'   => 'no',

    'auto-aof-rewrite-percentage' => 100,
    'auto-aof-rewrite-min-size'   => '64mb',

    'slowlog-log-slower-than'     => 10000,

    'slowlog-max-len'             => 1024,

    'list-max-ziplist-entries'    => 512,
    'list-max-ziplist-value'      => 64,

    'set-max-intset-entries'      => 512,

    'zset-max-ziplist-entries'    => 128,
    'zset-max-ziplist-value'      => 64,

    'activerehashing'             => 'yes',
  }

}
