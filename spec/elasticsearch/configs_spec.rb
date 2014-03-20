require 'spec_helper'

UUID = `mdata-get sdc:uuid`
privateIp = `mdata-get sdc:nics.1.ip`

describe file('/opt/local/etc/elasticsearch/elasticsearch.yml') do
  it { should be_file }
  it { should contain "cluster.name: " + UUID }
	it { should contain "node.name: " + privateIp }
	it { should contain "path.conf: /opt/local/etc/elasticsearch" }
	it { should contain "path.data: /var/db/elasticsearch" }
	it { should contain "path.work: /var/tmp/elasticsearch" }
	it { should contain "path.logs: /var/log/elasticsearch" }
	it { should contain "path.plugins: /opt/local/lib/elasticsearch/plugins" }
	it { should contain "network.host: " + privateIp }
	it { should contain "discovery.zen.ping.multicast.enabled: false" }
	it { should contain "processors: 24" }
end
