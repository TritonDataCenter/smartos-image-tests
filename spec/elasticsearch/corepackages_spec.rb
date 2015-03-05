require 'spec_helper'

# Make sure pkgin is updated first
describe command('pkgin -y up') do
  its(:exit_status) { should eq 0 }
end

## Common packages
describe package('elasticsearch') do
  it { should be_installed }
end

describe package('openjdk7') do
  it { should be_installed }
end

