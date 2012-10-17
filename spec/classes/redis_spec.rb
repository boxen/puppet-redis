require 'spec_helper'

describe 'redis' do
  let(:facts) do
    {
      :boxen_home => '/opt/boxen'
    }
  end

  it do
    should include_class('redis::config')
    should include_class('redis::package')
    should include_class('redis::service')
  end
end
