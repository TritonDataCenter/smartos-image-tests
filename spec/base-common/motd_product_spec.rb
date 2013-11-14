require 'spec_helper'

# Files that should be installed

describe file('/etc/product') do
  it { should be_file }
  it { should contain "Name: Joyent Instance" }
  it { should contain "Image: #{attr[:name]} #{attr[:base_version]}"  }
	#it { should contain "Documentation: #{attr[:doc_url]}" }
end

describe file('/etc/motd') do
	it { should be_file }
	it { should contain "Instance (#{attr[:name]} #{attr[:base_version]})" }
	#it { should contain "#{attr[:doc_url]}" }
end
