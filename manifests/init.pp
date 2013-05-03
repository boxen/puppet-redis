# Full Redis stack, including service management.
#
# Usage:
#
#     include redis
class redis (
    $port      = $redis::config::port,
    $configdir = $redis::config::configdir,
    $datadir   = $redis::config::datadir,
    $version   = $redis::config::version
  ) inherits redis::config {

  package { 'redis':
    ensure => $version,
    name   => $redis::config::package_name,
    notify => Service['redis'],
  }

  file { "${configdir}/redis.conf":
    content => template('redis/redis.conf.erb'),
    notify  => Service['redis'],
  }

  file { [
    $configdir,
    $datadir,
    $redis::config::logdir
  ]:
    ensure => directory
  }

  service { 'redis':
    ensure => running,
    name   => $redis::config::service_name,
  }

  case $::osfamily {
    'Debian': { include redis::debian }
    'Darwin': { include redis::darwin }
  }
}
