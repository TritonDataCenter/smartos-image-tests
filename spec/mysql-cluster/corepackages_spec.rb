require 'spec_helper'

# Make sure pkgin is updated first
describe command('pkgin -y up') do
  it { should return_exit_status 0 }
end

## Common packages

describe package('mysql-cluster') do
  it { should be_installed }
end
