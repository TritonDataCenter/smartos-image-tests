require 'spec_helper'

## zoneinit should be running
describe service('zoneinit') do
	it { should be_running }
end

## mdata should be running
describe service('mdata') do
  it { should be_running }
end
