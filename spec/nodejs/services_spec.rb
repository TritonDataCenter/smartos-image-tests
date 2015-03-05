require 'spec_helper'

describe service('mongodb') do
  it { should be_running }
  it { should be_enabled }
end

describe command('mongostat -uadmin -p$(mdata-get mongodb_pw) -n1') do
        its(:exit_status) { should eq 0 }
end

describe command('quickbackup-mongodb backup') do
        its(:exit_status) { should eq 0 }
end

describe command('svcs -Ho state pkgsrc/mms-agent') do
  its(:stdout) { should eq 'disabled' }
end

describe command('svcs -Ho state pkgsrc/quickbackup-mongodb') do
  its(:stdout) { should eq 'disabled' }
end
