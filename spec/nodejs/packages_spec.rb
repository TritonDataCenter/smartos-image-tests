require 'spec_helper'

# Make sure pkgin is updated first
describe command('pkgin -y up') do
  it { should return_exit_status 0 }
end

describe package('nodejs') do
  it { should be_installed }
end

## Version specific checks for node.js
# Since 13.3.0. See IMAGE-427
if attr[:base_version].delete('.').to_i == 1330 || attr[:base_version].delete('.').to_i == 1331
	describe package('nodejs-0.10.24') do
  	it { should be_installed }
	end
end

# Since 13.2.2. See IMAGE-388
if attr[:base_version].delete('.').to_i == 1322
	describe package('nodejs-0.10.21') do
  	it { should be_installed }
	end
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

describe package ('scmgit') do
  it { should be_installed }
end

describe package ('sqlite3') do
  it { should be_installed }
end

describe package ('htop') do
  it { should be_installed }

end

describe package ('gcc47') do
  it { should be_installed }
end

describe package ('dtracetools') do
  it { should be_installed }
end
