require "spec_helper"

describe "redis::package" do
  let(:facts) { default_test_facts }

  context "Darwin" do
    let(:facts) { default_test_facts.merge(:operatingsystem => "Darwin") }

    it do
      should contain_package("boxen/brews/redis")

      should include_class("boxen::config")

      should contain_homebrew__formula("redis")

      should contain_file("/test/boxen/homebrew/etc/redis.conf").with_ensure(:absent)
      should contain_file("/test/boxen/homebrew/var/db/redis").with_ensure(:absent)
    end
  end

  context "Ubuntu" do
    let(:facts) { default_test_facts.merge(:operatingsystem => "Ubuntu") }

    it do
      should contain_package("redis-server")
    end
  end
end
