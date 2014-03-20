require 'spec_helper'

if attr[:base_version].delete('.').to_i < 1340
describe service('mongodb') do
  it { should be_enabled }
end
end

