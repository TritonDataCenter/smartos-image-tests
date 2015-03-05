require 'spec_helper'

# Default services for image
describe command('svcs -Ho state pkgsrc/mysql-cluster:ndb_mgmd') do
  its(:stdout) { should eq 'disabled' }
end

describe command('svcs -Ho state pkgsrc/mysql-cluster:ndbd') do
  its(:stdout) { should eq 'disabled' }
end

#describe command('svcs -Ho state pkgsrc/mysql-cluster:mysqld') do
#  its(:stdout) { should eq 'disabled' }
#end
