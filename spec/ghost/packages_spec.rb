require 'spec_helper'

# Make sure pkgin is updated first
describe command('pkgin -y up') do
  it { should return_exit_status 0 }
end

describe package('nginx') do
  it { should be_installed }
end

describe package('postfix') do
  it { should be_installed }
end

describe package('nodejs') do
  it { should be_installed }
end
