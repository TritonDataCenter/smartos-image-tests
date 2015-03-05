require 'spec_helper'

describe file('/opt/local/etc/elasticsearch/elasticsearch.yml') do
  it { should be_file }
	it { should contain "path.conf: /opt/local/etc/elasticsearch" }
	it { should contain "path.data: /var/db/elasticsearch" }
	it { should contain "path.work: /var/tmp/elasticsearch" }
	it { should contain "path.logs: /var/log/elasticsearch" }
	it { should contain "path.plugins: /opt/local/lib/elasticsearch/plugins" }
	it { should contain "discovery.zen.ping.multicast.enabled: false" }
	it { should contain "processors: 24" }
end

describe command ('UUID=$(zonename) && grep -q "cluster.name: ${UUID}" /opt/local/etc/elasticsearch/elasticsearch.yml') do
  its(:exit_status) { should eq 0 }
end

describe command ('PRIVATE_IP=$(mdata-get sdc:nics.1.ip) && grep -q "node.name: ${PRIVATE_IP}" /opt/local/etc/elasticsearch/elasticsearch.yml') do
  its(:exit_status) { should eq 0 }
end

describe command ('PRIVATE_IP=$(mdata-get sdc:nics.1.ip) && grep -q "network.host: ${PRIVATE_IP}" /opt/local/etc/elasticsearch/elasticsearch.yml') do
  its(:exit_status) { should eq 0 }
end

describe command ('grep -q "elastic" /etc/project') do
  its(:exit_status) { should eq 0 }
end
