require 'spec_helper'

# Make sure pkgin is updated first
describe command('pkgin -y up') do
  its(:exit_status) { should eq 0 }
end

## Common packages

describe package('mysql-cluster') do
  it { should be_installed }
end
