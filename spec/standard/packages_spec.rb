require 'spec_helper'

# Make sure pkgin is updated first
describe command('pkgin -y up') do
  its(:exit_status) { should eq 0 }
end

describe package('nodejs') do
  it { should be_installed }
end

describe package('apache') do
  it { should be_installed }
end

describe package('php') do
  it { should be_installed }
end

describe package('postfix') do
  it { should be_installed }
end

describe package('nginx') do
  it { should be_installed }
end

describe package('mysql-server') do
  it { should be_installed }
end

describe package('gcc47') do
  it { should be_installed }
end

## Since 13.4.0
# At some point pkgsrc came to their senses and used a sensible name for git
if property[:base_version].delete('.').to_i >= 1400
  describe package('git') do
    it { should be_installed }
  end
  
  # Newer version of postgresql in 13.4.0
  describe package ('postgresql93-server') do
  	it { should be_installed }
  end
end

## 13.3.1 and earlier
if property[:base_version].delete('.').to_i <= 1331
  describe package('scmgit') do
    it { should be_installed }
  end
  
  describe package ('postgresql91-server') do
  	it { should be_installed }
  end
end

describe package ('python27') do
  it { should be_installed }
end

describe package ('perl') do
  it { should be_installed }
end

describe package ('ruby193') do
  it { should be_installed }
end

describe package ('chef') do
  it { should be_installed.by('gem') }
end

describe package ('ohai') do
  it { should be_installed.by('gem') }
end

## Since 13.3.1
if property[:base_version].delete('.').to_i >= 1331
	describe package ('php55-zendoptimizerplus') do
  	it { should be_installed }
	end
end
