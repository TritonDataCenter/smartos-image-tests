require 'spec_helper'

describe service('cassandra') do
  it { should be_enabled }
  it { should be_running }
end
