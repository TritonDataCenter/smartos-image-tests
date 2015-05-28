require 'spec_helper'

# Test to ensure directories under /etc are not owned by the
# '1000' user (the owner should be root)
# See IMAGE-743 and IMAGE-744
#
# The find command always returns 0 unless there was an error. To
# Get around that we pipe to grep which returns 0 for matches and 1
# for no matches. The expected value should be 1 -- no directories owned
# by the 1000 user.
describe command('find /etc -user 1000 -type d -ls | grep 1000') do
  its(:exit_status) { should eq 1 }
end


# Test to ensure directories under /var are not owned by the
# '1000' user (the owner should be root)
# See IMAGE-743 and IMAGE-744
describe command('find /var -user 1000 -type d -ls | grep 1000') do
  its(:exit_status) { should eq 1 }
end