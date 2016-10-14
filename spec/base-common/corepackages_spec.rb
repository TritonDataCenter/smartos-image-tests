require 'spec_helper'

# Make sure pkgin is updated first
describe command('pkgin -y up') do
  its(:exit_status) { should eq 0 }
end

## For 13.4.1 only. See IMAGE-476
if property[:base_version].delete('.').to_i == 1341
	# OpenSSL was patched to adddres the Heartbleed bug.
  describe package('openssl-1.0.1fnb1') do
  it { should be_installed }
  end
end


## Since 13.3.1. See IMAGE-437
if property[:base_version].delete('.').to_i >= 1331
  # wget package now preinstalled (works around the problem where the OS wget wasn't
  # happy with https URLs)
  describe package('wget') do
  it { should be_installed }
  end
end

## Since 13.3.0
# See IMAGE-340, IMAGE-404
# rsyslog pre-installed and running out of the box (in place of legacy syslog); has guardtime support built-in
if property[:base_version].delete('.').to_i >= 1330
  describe package('rsyslog') do
  it { should be_installed }
  end
end

## Common packages

describe package('mozilla-rootcerts') do
  it { should be_installed }
end

describe package('nodejs') do
  it { should be_installed }
end

if property[:version].delete('.').to_i == 1441
  describe package('nodejs-0.12.2') do
    it { should be_installed }
  end
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

describe package('curl') do
  it { should be_installed }
end

describe package('mozilla-rootcerts') do
  it { should be_installed }
end
