require 'spec_helper'

describe service('stingray') do
  it { should be_enabled }
end

