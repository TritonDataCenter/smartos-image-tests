require 'spec_helper'

# This test requires a VM to be provision with two IPs, preferably one public
# and one private.

# Test to ensure the VM has two interfaces, net0 and net1

# net0
describe command('ifconfig net0') do
  its(:exit_status) { should eq 0 }
end

describe command('dladm show-link net0 -o STATE -p') do
  its(:stdout) { should match /up/ }
end

# net1
describe command('ifconfig net1') do
  its(:exit_status) { should eq 0 }
end

describe command('dladm show-link net1 -o STATE -p') do
  its(:stdout) { should match /up/ }
end