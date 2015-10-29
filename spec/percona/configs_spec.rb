require 'spec_helper'

# Make sure mysql is listening on the private ip

#privateIp = `ipadm show-addr -o addrobj,addr | grep net1 |awk '{print $2}' | cut -d/ -f1`

# Disable private IP test
# describe file('/opt/local/etc/my.cnf') do
#    it { should be_file }
#    it { should contain "bind-address = " + privateIp }
# end
# 
