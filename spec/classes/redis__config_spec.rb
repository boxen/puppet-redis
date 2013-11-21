require "spec_helper"

describe "redis::config" do
  let(:facts) { default_test_facts }

  context "Darwin" do
    let(:facts) { default_test_facts.merge(:operatingsystem => "Darwin") }

    it do
      should include_class("boxen::config")

      should contain_file("/test/boxen/env.d/redis.sh").with_ensure(:absent)
      should contain_file("/Library/LaunchDaemons/dev.redis.plist")

      should contain_boxen__env_script("redis")

      %w(config/redis data/redis log/redis).each do |d|
        should contain_file("/test/boxen/#{d}").with_ensure(:directory)
      end

      should contain_file("/test/boxen/config/redis/redis.conf").with_ensure(:present)
    end
  end

  context "Ubuntu" do
    let(:facts) { default_test_facts.merge(:operatingsystem => "Ubuntu") }

    it do
      should_not include_class("boxen::config")

      should_not contain_file("/test/boxen/env.d/redis.sh").with_ensure(:absent)
      should_not contain_file("/Library/LaunchDaemons/dev.redis.plist")

      should_not contain_boxen__env_script("redis")
    end
  end

end
