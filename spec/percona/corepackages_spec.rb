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


describe package('percona-toolkit') do
  it { should be_installed }
end

describe package('quickbackup-percona') do
  it { should be_installed }
end

# Percona Xtrabackup package earlier than 13.4.2 
if property[:base_version].delete('.').to_i < 1342
  describe package('percona-xtrabackup') do
    it { should be_installed }
  end
end

# Percona Xtrabackup package for 13.4.2 
if property[:base_version].delete('.').to_i >= 1342
  describe package('percona56-xtrabackup') do
    it { should be_installed }
  end
end
