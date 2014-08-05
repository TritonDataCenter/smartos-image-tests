require 'spec_helper'

## Since 13.3.0
# See IMAGE-340, IMAGE-404
# rsyslog pre-installed and running out of the box (in place of legacy syslog); has guardtime support built-in

if attr[:base_version].delete('.').to_i >= 1330
  describe service('rsyslog') do
    it { should be_running }
  end
end

## zoneinit should be running
describe service('zoneinit') do
	it { should be_running }
end

## mdata should be running
describe service('mdata') do
  it { should be_running }
end
