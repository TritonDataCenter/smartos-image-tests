require 'spec_helper'

describe file('/opt/local/etc/mongodb.conf') do
  it { should be_file }
  it { should contain "dbpath = /var/mongodb" }
  it { should contain "bind_ip = 127.0.0.1" }
  it { should contain "port = 27017" }
  it { should contain "pidfilepath = /var/mongodb/mongodb.pid" }
  it { should contain "logpath = /var/log/mongodb/mongodb.log" }
end
