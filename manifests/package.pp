# Install redis from homebrew and notify service com.boxen.redis.
#
# Usage:
#
#     include redis::package
class redis::package {
  package { 'redis':
    notify => Service['com.boxen.redis']
  }
}
