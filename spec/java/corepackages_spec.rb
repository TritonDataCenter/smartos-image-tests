require 'spec_helper'

# Make sure pkgin is updated first
describe command('pkgin -y up') do
  its(:exit_status) { should eq 0 }
end

## Since 13.3.1. See IMAGE-448
# Change java from sun-jdk to openjdk
if attr[:base_version].delete('.').to_i >= 1331
  describe package('openjdk7') do
    it { should be_installed }
  end
end

# The 13.1.0 image used the Sun version of Java and JDK
if attr[:base_version].delete('.').to_i == 1310 
  describe package('sun-jdk6') do
    it { should be_installed }
  end
  describe package('sun-jre6') do
    it { should be_installed }
  end
end

## Common packages

describe package('apache') do
  it { should be_installed }
end

describe package('apache-ant') do
  it { should be_installed }
end

describe package('apache-maven') do
  it { should be_installed }
end

describe package('apache-tomcat') do
  it { should be_installed }
end

describe package('git-base') do
  it { should be_installed }
end
