require 'spec_helper'

# Make sure pkgin is updated first
describe command('pkgin -y up') do
  its(:exit_status) { should eq 0 }
end

describe package('nodejs') do
  it { should be_installed }
end

describe package('mongodb') do
  it { should be_installed }
end

describe package('quickbackup-mongodb') do
  it { should be_installed }
end

describe package('mms-agent') do
  it { should be_installed }
end

describe package ('git') do
  it { should be_installed }
end

describe package ('sqlite3') do
  it { should be_installed }
end

describe package ('htop') do
  it { should be_installed }
end

describe package ('build-essential') do
  it { should be_installed }
end

describe package ('dtracetools') do
  it { should be_installed }
end
