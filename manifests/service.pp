# Internal: management of the redis service

class redis::service(
  $ensure      = undef,

  $servicename = undef,
  $enable      = undef,
) {

  $real_ensure = $ensure ? {
    present => running,
    default => stopped,
  }

  service { $servicename:
    ensure => $real_ensure,
    enable => $enable,
    alias  => 'redis',
  }

  if $::operatingsystem == 'Darwin' {

    service { 'com.boxen.redis':
      ensure => stopped,
      enable => false,
    }

    ->
    Service[$servicename]
  }

}
