require 'spec_helper'

describe service('mongodb') do
  it { should be_enabled }
end

describe service('mongodb') do
  it { should be_running }
end

# Make sure we can log into mongodb
describe command('mongostat -uadmin -p$(mdata-get mongodb_pw) -n1') do
	its(:exit_status) { should eq 0 }
end

# Make sure quickbackup-mongodb works
describe command('quickbackup-mongodb backup') do
	its(:exit_status) { should eq 0 }
end


# Make sure mongodump works
describe command('mongodump -uadmin -p$(mdata-get mongodb_pw)  -db admin') do
  its(:exit_status) { should eq 0 }
end

