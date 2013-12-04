require 'spec_helper'

# Default services for image
describe service('percona') do
  it { should be_running }
end
