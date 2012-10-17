# Full Redis stack, including service management.
#
# Usage:
#
#     include redis
class redis {
  include redis::config
  include redis::package
  include redis::service
}
