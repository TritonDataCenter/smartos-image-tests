require 'spec_helper'

describe service('mongodb') do
  it { should be_running }
  it { should be_enabled }
end

describe command('mongostat -uadmin -p$(mdata-get mongodb_pw) -n1') do
        it { should return_exit_status 0 }
end

describe command('quickbackup-mongodb backup') do
        it { should return_exit_status 0 }
end

describe command('svcs -Ho state pkgsrc/mms-agent') do
  it { should return_stdout 'disabled' }
end

describe command('svcs -Ho state pkgsrc/quickbackup-mongodb') do
  it { should return_stdout 'disabled' }
end
