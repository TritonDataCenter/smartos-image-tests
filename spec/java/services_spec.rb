require 'spec_helper'

describe service('apache') do
  it { should be_enabled }
  it { should be_running }
end

describe service('tomcat') do
  it { should be_enabled }
  it { should be_running }
end
