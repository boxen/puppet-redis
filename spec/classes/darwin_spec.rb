require 'spec_helper'

describe 'redis' do
let(:boxen_home) { '/opt/boxen' }
let(:brewdir)    { "#{boxen_home}/homebrew" }
let(:configdir)  { "#{boxen_home}/config/redis" }
let(:configfile) { "#{configdir}/redis.conf" }
let(:datadir)    { "#{boxen_home}/data/redis" }
let(:envdir)     { "#{boxen_home}/env.d" }
let(:logdir)     { "#{boxen_home}/log/redis" }
let(:facts) do
  {
    :boxen_home => boxen_home,
    :luser      => 'wfarr',
    :boxen_user => 'wfarr'
  }
end

  it do
    should contain_file(configdir).with_ensure('directory')
    should contain_file(datadir).with_ensure('directory')
    should contain_file(logdir).with_ensure('directory')

    should contain_file(configfile).with({
      #:content => File.read('spec/fixtures/redis.conf'),
      :notify => 'Service[dev.redis]'
    })

    should contain_file("#{brewdir}/etc/redis.conf").with({
      :ensure  => 'absent',
      :require => 'Package[boxen/brews/redis]'
    })

    should contain_file("#{envdir}/redis.sh")
    #.with({
    #  :content => File.read('spec/fixtures/redis.sh')
    #})

    should contain_homebrew__formula('redis').with_before('Package[boxen/brews/redis]')
    should contain_package('boxen/brews/redis').with({
      :ensure => '2.6.9-boxen1',
      :notify => 'Service[dev.redis]'
    })

    should include_class('redis::config')

    should contain_file('/Library/LaunchDaemons/dev.redis.plist').with({
      #:content => File.read('spec/fixtures/redis.plist'),
      :group   => 'wheel',
      :notify  => 'Service[dev.redis]',
      :owner   => 'root'
    })

    should contain_file('/opt/boxen/homebrew/var/db/redis').with({
      :ensure  => 'absent',
      :force   => true,
      :recurse => true,
      :require => 'Package[boxen/brews/redis]'
    })

    should contain_service('dev.redis').with_ensure('running')
  end
end
