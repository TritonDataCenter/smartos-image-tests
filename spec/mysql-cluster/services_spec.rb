require 'spec_helper'

# Default services for image
describe command('svcs -Ho state pkgsrc/mysql-cluster:ndb_mgmd') do
  it { should return_stdout 'disabled' }
end

describe command('svcs -Ho state pkgsrc/mysql-cluster:ndbd') do
  it { should return_stdout 'disabled' }
end

#describe command('svcs -Ho state pkgsrc/mysql-cluster:mysqld') do
#  it { should return_stdout 'disabled' }
#end
