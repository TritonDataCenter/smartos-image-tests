require 'spec_helper'

# sm-list-dbs

describe command('sm-list-dbs mysql') do
  its(:stdout) { should match /information_schema/ }
  its(:stdout) { should match /mysql/ }
  its(:stdout) { should match /performance_schema/ }
  its(:exit_status) { should eq 0 }
end

describe command('sm-list-dbs') do
  its(:exit_status) { should eq 2 }
  its(:stderr) { should match /Usage: \/opt\/local\/bin\/sm-list-dbs [options] TYPE/ }
end


