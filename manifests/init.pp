class redis {
  include redis::config
  include redis::package
  include redis::service
}
