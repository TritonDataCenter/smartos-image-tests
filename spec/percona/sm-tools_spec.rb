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

# sm-list-dbusers

describe command('sm-list-dbusers mysql') do
  its(:stdout) { should match /Listing MySQL users/ }
  its(:exit_status) { should eq 0 }
end

describe command('sm-list-dbusers') do
  its(:exit_status) { should eq 2 }
  its(:stderr) { should match /Usage: \/opt\/local\/bin\/sm-list-dbusers [options] TYPE/ }
end

# sm-create-db

describe command('sm-create-db mysql testdb') do
  its(:stdout) { should match /\* Created MySQL database testdb./ }
  its(:exit_status) { should eq 0 }
end

describe command('sm-list-dbs mysql') do
  its(:stdout) { should match /testdb/ }
  its(:exit_status) { should eq 0 }
end

describe command('sm-create-db') do
  its(:exit_status) { should eq 2 }
  its(:stderr) { should match /Usage: \/opt\/local\/bin\/sm-list-dbusers [options] TYPE DATABASE/ }
end
