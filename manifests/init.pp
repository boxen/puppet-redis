# Full Redis stack, including service management.
#
# Usage:
#
#     include redis
class redis(
  $ensure        = undef,

  $configdir     = undef,
  $datadir       = undef,
  $logdir        = undef,
  $host          = undef,
  $port          = undef,
  $executable    = undef,

  $package       = undef,
  $version       = undef,

  $config_values = undef,

  $enable        = undef,
  $servicename   = undef,
) {
  validate_string(
    $ensure,
    $configdir,
    $datadir,
    $logdir,
    $host,
    $port,
    $package,
    $version,
    $servicename,
  )

  validate_bool(
    $enable,
  )

  class { 'redis::config':
    ensure        => $ensure,

    configdir     => $configdir,
    datadir       => $datadir,
    logdir        => $logdir,
    host          => $host,
    port          => $port,
    executable    => $executable,

    config_values => $config_values,

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
