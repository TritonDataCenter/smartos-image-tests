require 'spec_helper'

describe command ('PRIVATE_IP=$(mdata-get sdc:nics.1.ip) && grep -q "bind-address=${PRIVATE_IP}" /opt/local/etc/my.cnf') do
  its(:exit_status) { should eq 0 }
end

describe command ('grep -q "ndb-connectstring=" /opt/local/etc/my.cnf') do
  its(:exit_status) { should eq 0 }
end

describe command ('grep -q "ndbcluster" /opt/local/etc/my.cnf') do
  its(:exit_status) { should eq 0 }
end

describe command ('grep -q "configdir=/var/mysql" /opt/local/etc/my.cnf') do
  its(:exit_status) { should eq 0 }
end

describe command ('grep -q "configdir=/var/mysql" /opt/local/etc/my.cnf') do
  its(:exit_status) { should eq 0 }
end

describe command ('PRIVATE_IP=$(mdata-get sdc:nics.1.ip) && grep -q "hostname=${PRIVATE_IP}" /opt/local/etc/mysql-cluster.ini') do
  its(:exit_status) { should eq 0 }
end
