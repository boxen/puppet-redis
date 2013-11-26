require "spec_helper"

describe "redis::service" do
  let(:facts) { default_test_facts }

  context "Darwin" do
    let(:facts) { default_test_facts.merge(:operatingsystem => "Darwin") }

    it do
      should contain_service("dev.redis").with_alias('redis')
      should contain_service("com.boxen.redis").with_ensure(:stopped)
    end
  end

  context "Ubuntu" do
    let(:facts) { default_test_facts.merge(:operatingsystem => "Ubuntu") }

    it do
      should contain_service("redis-server").with_alias('redis')
    end
  end
end
