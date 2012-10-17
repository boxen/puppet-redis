require 'spec_helper'

describe 'redis::package' do
  it do
    should contain_package('redis').with_notify('Service[com.boxen.redis]')
  end
end
