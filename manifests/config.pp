# Internal: configuration required to do redis

class redis::config(
  $ensure        = $redis::params::ensure,

  $configdir     = $redis::params::configdir,
  $datadir       = $redis::params::datadir,
  $logdir        = $redis::params::logdir,
  $host          = $redis::params::host,
  $port          = $redis::params::port,
  $pidfile       = $redis::params::pidfile,
  $executable    = $redis::params::executable,

  $servicename   = $redis::params::servicename,
) inherits redis::params {

  $dir_ensure = $ensure ? {
    present => directory,
    default => absent,
  }

  if $::operatingsystem == 'Darwin' {
    include boxen::config

    file {
      "${boxen::config::envdir}/redis.sh":
        ensure => absent ;

      "/Library/LaunchDaemons/${servicename}.plist":
        content => template('redis/darwin/redis.plist.erb'),
        group   => 'wheel',
        owner   => 'root' ;
    }

    ->
    boxen::env_script { 'redis':
      ensure   => $ensure,
      content  => template('redis/darwin/env.sh.erb'),
      priority => 'lower',
    }

  }

  file {
    [
      $configdir,
      $datadir,
      $logdir,
    ]:
      ensure => $dir_ensure ;

    "${configdir}/redis.conf":
      ensure  => $ensure,
      content => template('redis/redis.conf.erb') ;
  }


}
