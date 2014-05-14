require 'spec_helper'

describe command ('PRIVATE_IP=$(mdata-get sdc:nics.1.ip) && grep -q "listen_addresses = \'${PRIVATE_IP}\'" /var/pgsql/data/postgresql.conf') do
  it { should return_exit_status 0 }
end

describe command ('PRIVATE_IP=$(mdata-get sdc:nics.1.ip) && egrep -q "host\s+all\s+all\s+${PRIVATE_IP}/32\s+password" /var/pgsql/data/pg_hba.conf') do
  it { should return_exit_status 0 }
end
