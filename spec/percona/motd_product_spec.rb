require 'spec_helper'

# Files that should be installed

describe file('/etc/product') do
  it { should be_file }
  it { should contain "Base Image: #{attr[:name]} #{attr[:base_version]}"  }
end

