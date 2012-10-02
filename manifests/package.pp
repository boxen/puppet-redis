class redis::package {
  package { 'redis':
    notify => Service['com.setup.redis']
  }
}
