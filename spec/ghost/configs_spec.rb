require 'spec_helper'

describe file('/home/ghost/ghost/config.js') do
  it { should be_file }
  it { should contain 'host: \'127.0.0.1\',' }
  it { should contain 'port: \'2368\'' }
end

describe command ('PUBLIC_IP=$(mdata-get sdc:nics.0.ip) && grep -q "url: \'http://${PUBLIC_IP}\'," /home/ghost/ghost/config.js') do
  its(:exit_status) { should eq 0 }
end

describe command ('PUBLIC_IP=$(mdata-get sdc:nics.0.ip) && grep -q "fromaddress: \'ghost@${PUBLIC_IP}\'," /home/ghost/ghost/config.js') do
  its(:exit_status) { should eq 0 }
end
