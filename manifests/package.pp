class redis::package {
  package { 'redis':
    notify => Service['com.boxen.redis']
  }
}
