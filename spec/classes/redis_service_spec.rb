require 'spec_helper'

describe 'redis::service' do
  let(:facts) do
    {
      :boxen_home => '/opt/boxen',
      :luser      => 'wfarr'
    }
  end

  it do
    should include_class('redis::config')

    should contain_file('/Library/LaunchDaemons/dev.redis.plist').with({
      :content => File.read('spec/fixtures/redis.plist'),
      :group   => 'wheel',
      :notify  => 'Service[dev.redis]',
      :owner   => 'root'
    })

    should contain_file('/opt/boxen/homebrew/var/db/redis').with({
      :ensure  => 'absent',
      :force   => true,
      :recurse => true,
      :require => 'Package[redis]'
    })

    should contain_service('dev.redis').with_ensure('running')
  end
end
