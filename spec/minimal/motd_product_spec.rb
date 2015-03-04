require 'spec_helper'

# Files that should be installed

describe file('/etc/product') do
  it { should be_file }
  it { should contain "Name: Joyent Instance" }
  it { should contain "Image: #{property[:name]} #{property[:version]}"  }
  it { should contain "Documentation: #{property[:doc_url]}" }
end

describe file('/etc/motd') do
        it { should be_file }
        it { should contain "Instance (#{property[:name]} #{property[:version]})" }
        it { should contain "#{property[:doc_url]}" }
end
