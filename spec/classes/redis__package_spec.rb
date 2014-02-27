require "spec_helper"

describe "redis::package" do
  let(:facts) { default_test_facts }
  let(:params) { {
    'ensure' => 'present',
    'package' => 'boxen/brews/redis',
    'version' => '2.8.6-boxen1'
  } }

  it do
    should contain_package("boxen/brews/redis")
  end

  context "Darwin" do
    let(:facts) { default_test_facts.merge(:operatingsystem => "Darwin") }

    it do
      should include_class("boxen::config")

      should contain_homebrew__formula("redis")

      should contain_file("/test/boxen/homebrew/etc/redis.conf").with_ensure(:absent)
      should contain_file("/test/boxen/homebrew/var/db/redis").with_ensure(:absent)
    end
  end

  context "Ubuntu" do
    let(:facts) { default_test_facts.merge(:operatingsystem => "Ubuntu") }

    it do
      should_not include_class("boxen::config")
      should_not contain_homebrew__formula("redis")
      should_not contain_file("/test/boxen/homebrew/etc/redis.conf").with_ensure(:absent)
      should_not contain_file("/test/boxen/homebrew/var/db/redis").with_ensure(:absent)
    end
  end
end
