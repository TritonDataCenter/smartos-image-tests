require 'spec_helper'

describe service('elasticsearch') do
  it { should be_enabled }
end

