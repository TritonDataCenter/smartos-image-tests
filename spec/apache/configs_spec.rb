require 'spec_helper'

describe command ('PUBLIC_IP=$(mdata-get sdc:nics.0.ip) && curl http://${PUBLIC_IP}/ 2>/dev/null | grep -q "${PUBLIC_IP}"') do
  its(:exit_status) { should eq 0 }
end

describe command ('PUBLIC_IP=$(mdata-get sdc:nics.0.ip) PRIVATE_IP=$(mdata-get sdc:nics.1.ip) && curl http://${PUBLIC_IP}/ 2>/dev/null | grep -q "${PRIVATE_IP}"') do
  its(:exit_status) { should eq 0 }
end

describe command ('PRIVATE_IP=$(mdata-get sdc:nics.1.ip) && curl http://${PRIVATE_IP}/ 2>/dev/null | grep -q "${PRIVATE_IP}"') do
  its(:exit_status) { should eq 0 }
end

describe command ('PUBLIC_IP=$(mdata-get sdc:nics.0.ip) PRIVATE_IP=$(mdata-get sdc:nics.1.ip) && curl http://${PRIVATE_IP}/ 2>/dev/null | grep -q "${PUBLIC_IP}"') do
  its(:exit_status) { should eq 0 }
end
