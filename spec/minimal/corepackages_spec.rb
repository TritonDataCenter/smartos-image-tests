require 'spec_helper'

# Make sure pkgin is updated first
describe command('pkgin -y up') do
  its(:exit_status) { should eq 0 }
end

## Common packages

describe package('changepass') do
  it { should be_installed }
end

describe package('mozilla-rootcerts') do
  it { should be_installed }
end

describe package('openssl') do
  it { should be_installed }
end

if property[:version].delete('.').to_i == 1441
  describe package('openssl-1.0.1m') do
    it { should be_installed }
  end
end

describe package('pkgin') do
  it { should be_installed }
end

if property[:version].delete('.').to_i == 1441
  describe package('pkgin-0.8.0') do
    it { should be_installed }
  end
end

describe package('pkgsrc-gnupg-keys') do
  it { should be_installed }
end

if property[:version].delete('.').to_i == 1441
  describe package('pkgsrc-gnupg-keys-20150416') do
    it { should be_installed }
  end
end


describe package('smtools') do
  it { should be_installed }
end

describe package('zoneinit') do
  it { should be_installed }
end
