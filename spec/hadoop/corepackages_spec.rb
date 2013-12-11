require 'spec_helper'

# Make sure pkgin is updated first
describe command('pkgin -y up') do
  it { should return_exit_status 0 }
end

## Since 13.3.0
# See IMAGE-387
# * Base image is base64-13.3.0 (2013Q3)
# * Hadoop version is 1.1.2
# * Hbase version is 0.94.7
# * Hcatalog version is 0.5.0
# * Hive version is 0.11.0
# * Pig version is 0.10.1
# * Flume version is 1.4.0
# * Templeton version is 0.1.0
# * Zookeeper version is 3.4.5
# * Oozie version is 3.3.1
# * Sqoop version is 1.4.2
# * Mahout version is 0.7

## Common packages

describe package('hadoop') do
  it { should be_installed }
end

describe package('hbase') do
  it { should be_installed }
end

describe package('hcatalog') do
  it { should be_installed }
end

describe package('hive') do
  it { should be_installed }
end

describe package('pig') do
  it { should be_installed }
end

describe package('flume') do
  it { should be_installed }
end

describe package('templeton') do
  it { should be_installed }
end

describe package('zookeeper-server') do
  it { should be_installed }
end

describe package('zookeeper-client') do
  it { should be_installed }
end

describe package('oozie') do
  it { should be_installed }
end

describe package('sqoop') do
  it { should be_installed }
end

describe package('mahout') do
  it { should be_installed }
end