require 'spec_helper'

# Make sure postgresql is listening on the private ip

privateIp = `/usr/sbin/mdata-get sdc:nics.1.ip`

describe file('/var/pgsql/data/postgresql.conf') do
   it { should be_file }
   it { should contain "listen_addresses = '" + privateIp + "'" }
end

