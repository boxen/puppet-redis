require 'spec_helper'

describe 'redis' do
  let(:facts) {
    {
      :osfamily => 'Debian'
    }
  }
  let(:configfile) { '/etc/redis.conf' }
  let(:package_name) { 'redis-server' }
  let(:service_name) { 'redis-server' }
  let(:version) { 'installed' }

  it do
    should contain_file(configfile).with({
      :notify => 'Service[redis]'
    })
    should contain_package('redis').with({
      :ensure => version,
      :name   => package_name,
      :notify => 'Service[redis]'
    })
    should include_class('redis::config')
    should contain_service('redis').with({
      :ensure  => 'running',
      :name    => service_name
    })
  end
end
