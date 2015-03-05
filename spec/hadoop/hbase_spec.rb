require 'spec_helper'

# Check to see if hbase starts without error
describe command('start-hbase.sh') do
  its(:exit_status) { should eq 0 }
end

# Make sure Java process is killed off when done
describe command('pkill -9 java') do
  its(:exit_status) { should eq 0 }
end
