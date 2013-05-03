require 'spec_helper'

describe 'redis' do
  context 'Debian' do
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
  context 'Darwin' do
    let(:facts) {
      {
      :osfamily   => 'Darwin',
      :boxen_home => '/opt/boxen'
      }
    }
    let(:configfile) { "#{facts[:boxen_home]}/config/redis/redis.conf" }
    let(:package_name) { 'boxen/brews/redis' }
    let(:service_name) { 'dev.redis' }
    let(:version) { '2.6.9-boxen1' }

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

end
