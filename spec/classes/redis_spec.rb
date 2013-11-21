require "spec_helper"

describe "redis" do
  let(:facts) { default_test_facts }

  it do
    should contain_class("redis::config")
    should contain_class("redis::package")
    should contain_class("redis::service")
  end
end
