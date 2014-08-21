require 'spec_helper'

describe file('/etc/product') do
  it { should be_file }
  it { should contain "Base Image: #{property[:base_name]} #{property[:base_version]}"  }
end

