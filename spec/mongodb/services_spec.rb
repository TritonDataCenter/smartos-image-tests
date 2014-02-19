require 'spec_helper'

describe service('mongodb') do
  it { should be_enabled }
end

describe service('mongodb') do
  it { should be_running }
end
