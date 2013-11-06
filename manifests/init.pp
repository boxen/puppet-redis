# Full Redis stack, including service management.
#
# Usage:
#
#     include redis
class redis(
  $ensure        = $redis::params::ensure,

  $configdir     = $redis::params::configdir,
  $executable    = $redis::params::executable,
  $configuration = {},

  $package       = $redis::params::package,
  $version       = $redis::params::version,

  $enable        = $redis::params::enable,
  $servicename   = $redis::params::servicename,
 ) inherits redis::params {

 class { 'redis::config':
   ensure        => $ensure,

   configdir     => $configdir,
   executable    => $executable,
   configuration => $configuration,
   servicename   => $servicename,
 }

 ~>
 class { 'redis::package':
   ensure  => $ensure,

   package => $package,
   version => $version,
 }

 ~>
 class { 'redis::server':
   ensure      => $ensure,

   enable      => $enable,
   servicename => $servicename,
 }

}
