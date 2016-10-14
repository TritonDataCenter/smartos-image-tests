require 'spec_helper'

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

describe package('pkgin') do
  it { should be_installed }
end

describe package('pkgsrc-gnupg-keys') do
  it { should be_installed }
end

describe package('smtools') do
  it { should be_installed }
end

describe package('zoneinit') do
  it { should be_installed }
end
