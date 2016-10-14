require 'spec_helper'

# Make sure pkgin update works
describe command('pkgin -y up') do
  its(:exit_status) { should eq 0 }
end

# Make sure an upgrade works
describe command('pkgin -y fug') do
  its(:exit_status) { should eq 0 }
end

# Test adding a package
describe command('pkgin -y in nano') do
  its(:exit_status) { should eq 0 }
end

# Test removing a package
describe command('pkgin -y rm nano') do
  its(:exit_status) { should eq 0 }
end
