require 'spec_helper'

# Make sure pkgin is updated first
describe command('pkgin -y up') do
  it { should return_exit_status 0 }
end

describe package('stingray') do
  it { should be_installed }
end

# Since 13.4.0
# IMAGE-411 Java Extensions enabled
describe package('openjdk7') do
  it { should be_installed }
end

# Check for Manta
describe file('/opt/local/lib/node_modules/manta/') do
	it { should be_directory }
end

# Check for a respresentative symlink
describe file('/opt/local/bin/mls') do
	it { should be_linked_to '/opt/local/lib/node_modules/manta/bin/mls'
end

