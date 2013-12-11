require 'spec_helper'

# Check to see if hbase starts without error
describe command('start-hbase.sh') do
  it { should return_exit_status 0 }
end

# Make sure hbase stops without error as well
describe command('stop-hbase.sh') do
  it { should return_exit_status 0 }
end
