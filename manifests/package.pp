# Install redis from homebrew and notify service dev.redis.
#
# Usage:
#
#     include redis::package
class redis::package {
  package { 'redis':
    notify => Service['dev.redis']
  }
}
