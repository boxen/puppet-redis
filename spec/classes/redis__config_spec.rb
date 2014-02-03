require "spec_helper"

describe "redis::config" do
  let(:facts) { default_test_facts }
  let(:params) { {
    'ensure'       => 'present',
    'configdir'    => '/test/boxen/config/redis',
    'datadir'      => '/test/boxen/data/redis',
    'logdir'       => '/test/boxen/log/redis',
    'host'         => '127.0.0.1',
    'port'         => '16379',
    'pidfile'      => '/test/boxen/data/redis/pid',
    'executable'   => '/test/boxen/homebrew/bin/redis-server',
    'config_values' => { 'port' => '6379', 'daemonize' => 'no' },

    'servicename'  => 'dev.redis'
  } }

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
