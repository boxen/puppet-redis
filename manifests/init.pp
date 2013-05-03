# Full Redis stack, including service management.
#
# Usage:
#
#     include redis
class redis (
  $port    = $redis::config::port,
  $datadir = $redis::config::datadir,
  $version = $redis::config::version
) inherits redis::config {

  package { 'redis':
    ensure => $version,
    name   => $redis::config::package_name,
    notify => Service['redis'],
  }

  file { $redis::config::configfile:
    content => template('redis/redis.conf.erb'),
    notify  => Service['redis'],
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
