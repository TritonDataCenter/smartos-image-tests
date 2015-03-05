require 'spec_helper'

# Make sure pkgin is updated first
describe command('pkgin -y up') do
  its(:exit_status) { should eq 0 }
end

describe package('mongodb') do
  it { should be_installed }
end

describe package('quickbackup-mongodb') do
  it { should be_installed }
end

describe package('mms-agent') do
  it { should be_installed }
end

## Version specific checks for mongodb
# Since 13.4.2. See IMAGE-482
if attr[:base_version].delete('.').to_i == 1342
	describe package('mongodb-2.6.0') do
  	it { should be_installed }
	end
end

# Since 13.3.1. See IMAGE-429
if attr[:base_version].delete('.').to_i == 1330 || attr[:base_version].delete('.').to_i == 1331
	describe package('mongodb-2.4.9') do
  	it { should be_installed }
	end
end


# Since 13.2.1. See IMAGE-429
if attr[:base_version].delete('.').to_i == 1320 || attr[:base_version].delete('.').to_i == 1321
	describe package('mongodb-2.4.6') do
		it { should be_installed }
	end
end
