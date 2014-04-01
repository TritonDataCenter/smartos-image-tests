require 'spec_helper'

describe file('/etc/product') do
  it { should be_file }
	it { should contain "Base Image: #{attr[:base_name]} #{attr[:base_version]}" }
end
