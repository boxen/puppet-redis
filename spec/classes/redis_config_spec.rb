require 'spec_helper'

describe 'redis::config' do
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
      :luser      => 'wfarr'
    }
  end

  it do
    should contain_file(configdir).with_ensure('directory')
    should contain_file(datadir).with_ensure('directory')
    should contain_file(logdir).with_ensure('directory')

    should contain_file(configfile).with({
      :content => File.read('spec/fixtures/redis.conf'),
      :notify => 'Service[dev.redis]'
    })

    should contain_file("#{brewdir}/etc/redis.conf").with({
      :ensure  => 'absent',
      :require => 'Package[redis]'
    })

    should contain_file("#{envdir}/redis.sh").with({
      :content => File.read('spec/fixtures/redis.sh')
    })
  end
end
