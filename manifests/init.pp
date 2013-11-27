# Full Redis stack, including service management.
#
# Usage:
#
#     include redis
class redis(
  $ensure        = $redis::params::ensure,

  $configdir     = $redis::params::configdir,
  $datadir       = $redis::params::datadir,
  $logdir        = $redis::params::logdir,
  $host          = $redis::params::host,
  $port          = $redis::params::port,
  $executable    = $redis::params::executable,

  $package       = $redis::params::package,
  $version       = $redis::params::version,

  $enable        = $redis::params::enable,
  $servicename   = $redis::params::servicename,
) inherits redis::params {

  class { 'redis::config':
    ensure        => $ensure,

    configdir     => $configdir,
    datadir       => $datadir,
    logdir        => $logdir,
    host          => $host,
    port          => $port,
    executable    => $executable,

    servicename   => $servicename,
    notify        => Service['redis'],
  }

  ~>
  class { 'redis::package':
    ensure  => $ensure,

    package => $package,
    version => $version,
  }

  ~>
  class { 'redis::service':
    ensure      => $ensure,

    enable      => $enable,
    servicename => $servicename,
  }

}
