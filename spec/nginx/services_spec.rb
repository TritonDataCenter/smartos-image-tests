require 'spec_helper'

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end
