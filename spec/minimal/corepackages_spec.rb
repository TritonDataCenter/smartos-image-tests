require 'spec_helper'

# Make sure pkgin is updated first
describe command('pkgin -y up') do
  its(:exit_status) { should eq 0 }
end

## Common packages

describe package('changepass') do
  it { should be_installed }
end

describe package('mozilla-rootcerts') do
  it { should be_installed }
end

describe package('smtools') do
  it { should be_installed }
end

describe package('zoneinit') do
  it { should be_installed }
end
