require 'spec_helper'

describe service('postfix') do
  it { should be_enabled }
  it { should be_running }
end

describe command('svcs -Ho state pkgsrc/nginx') do
  it { should return_stdout 'disabled' }
end

describe command('svcs -Ho state application/ghost') do
  it { should return_stdout 'disabled' }
end
