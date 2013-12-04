require 'spec_helper'

# Make sure pkgin is updated first
describe command('pkgin -y up') do
  it { should return_exit_status 0 }
end

## Since 13.3.0
# See IMAGE-381 
# * Percona Server version is 5.6.13
# * Xtrabackup version is 2.1.3
# * Percona ToolKit version is 2.1.7
# * Quickbackup version is 3.5

## Common packages

describe package('percona-server') do
  it { should be_installed }
end

describe package('percona-xtrabackup') do
  it { should be_installed }
end

describe package('percona-toolkit') do
  it { should be_installed }
end

describe package('quickbackup-percona') do
  it { should be_installed }
end
