require 'spec_helper'

# Default services for image
describe service('postgresql') do
  it { should be_running }
end
