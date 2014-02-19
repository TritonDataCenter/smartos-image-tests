require 'spec_helper'

# Make sure pkgin is updated first
describe command('pkgin -y up') do
  it { should return_exit_status 0 }
end

# Since 13.3.1
# postgresql-13.3.1
# * Base image is base64-13.3.1 (2013Q3)
# * PostgreSQL Server version is 9.3.0
# * PostgreSQL Admin Pack version is 9.3.0
# * PostgreSQL Monitoring version is 9.3.0
# * PostgreSQL Server tuned by default
# * Includes PostgreSQL loadable modules adminpack, pg_buffercache, pg_stat_statements, and auto_explain
# * Includes DTrace scripts from 'dtracetools' package
# * Initial release

## Common packages

describe package('postgresql93-server') do
  it { should be_installed }
end

describe package('postgresql93-adminpack') do
  it { should be_installed }
end

describe package('postgresql93-monitoring') do
  it { should be_installed }
end

describe package('postgresql93-pgbench') do
  it { should be_installed }
end

describe package('postgresql93-pgcrypto') do
  it { should be_installed }
end

describe package('dtracetools') do
  it { should be_installed }
end


## Version specific tests
# Since 13.3.1. See IMAGE-455
if attr[:base_version].delete('.').to_i == 1330 || attr[:base_version].delete('.').to_i == 1331
	describe package('postgresql93-server-9.3.0') do
  	it { should be_installed }
	end
  
  describe package('postgresql93-adminpack-9.3.0') do
    it { should be_installed }
  end

  describe package('postgresql93-monitoring-9.3.0') do
    it { should be_installed }
  end

  describe package('postgresql93-pgbench-9.3.0') do
    it { should be_installed }
  end

  describe package('postgresql93-pgcrypto-9.3.0') do
    it { should be_installed }
  end

  describe package('dtracetools-0.3') do
    it { should be_installed }
  end
  
end
