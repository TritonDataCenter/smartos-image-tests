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
end

# sm-list-dbusers

describe command('sm-list-dbusers mysql') do
  its(:stdout) { should match /Listing MySQL users/ }
  its(:exit_status) { should eq 0 }
end

describe command('sm-list-dbusers') do
  its(:exit_status) { should eq 2 }
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
end

# sm-create-dbuser

describe command('sm-create-dbuser mysql testdbuser CavrybcysUng9Oli testdb') do
  its(:stdout) { should match /\* Created MySQL user testdbuser pass CavrybcysUng9Oli with access to testdb from anywhere./ }
  its(:exit_status) { should eq 0 }
end

describe command('sm-list-dbusers mysql') do
  its(:stdout) { should match /testdbuser/ }
  its(:exit_status) { should eq 0 }
end

describe command('sm-create-dbuser') do
  its(:exit_status) { should eq 2 }
end

# sm-remove-dbuser

describe command('sm-remove-dbuser mysql testdbuser') do
  its(:stdout) { should match /\* Removed MySQL user testdbuser./ }
  its(:exit_status) { should eq 0 }
end

describe command('sm-remove-dbuser') do
  its(:exit_status) { should eq 2 }
end

# sm-remove-db

describe command('sm-remove-db mysql testdb') do
  its(:stdout) { should match /\* Removed MySQL database testdb./ }
  its(:exit_status) { should eq 0 }
end

describe command('sm-remove-db') do
  its(:exit_status) { should eq 2 }
end

# sm-tune-mysql

describe command('sm-tune-mysql') do
  its(:stdout) { should match /\* * Tuning MySQL, this can take up to 60 seconds../ }
  its(:exit_status) { should eq 0 }
end

## Test tune config

### Disable percona service first so we don't have any conflicts
describe command('svcadm disable percona') do
  its(:exit_status) { should eq 0 }
end

describe command('mysqld --help --verbose --defaults-file=/opt/local/etc/my.cnf.tuned') do
  its(:exit_status) { should eq 0 }
end

describe command('svcadm enable percona') do
  its(:exit_status) { should eq 0 }
end
