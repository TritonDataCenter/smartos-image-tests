require 'spec_helper'

if attr[:base_version].delete('.').to_i <= 1331
  describe file('/opt/local/etc/mongodb.conf') do
    it { should be_file }
    it { should contain "dbpath = /var/mongodb" }
    it { should contain "bind_ip = 127.0.0.1" }
    it { should contain "port = 27017" }
    it { should contain "pidfilepath = /var/mongodb/mongodb.pid" }
    it { should contain "logpath = /var/log/mongodb/mongodb.log" }
  end
end

# MongoDB 2.6.0 and onward changes configuration file. DATASET-1006
if attr[:base_version].delete('.').to_i >= 1342
  describe file('/opt/local/etc/mongod.conf') do
    it { should be_file }
    it { should contain "dbpath=/var/mongodb" }
    it { should contain "bind_ip = 127.0.0.1" }
    it { should contain "port = 27017" }
    it { should contain "pidfilepath = /var/mongodb/mongod.pid" }
    it { should contain "logpath=/var/log/mongodb/mongod.log" }
    it { should contain "nohttpinterface = true" }
  end
end
