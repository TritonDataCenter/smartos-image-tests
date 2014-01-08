require 'spec_helper'

describe service('apache') do
  it { should be_enabled }
end

describe service('mysql') do
  it { should be_running }
end

describe service('postfix') do
  it { should be_enabled }
end
