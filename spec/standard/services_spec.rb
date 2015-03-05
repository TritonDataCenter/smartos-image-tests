require 'spec_helper'

describe service('apache') do
  it { should be_enabled }
  it { should be_running }
end

describe service('mysql') do
  it { should be_enabled }
  it { should be_running }
end

describe service('postfix') do
  it { should be_enabled }
  it { should be_running }
end

describe command('svcs -Ho state pkgsrc/postgresql') do
  its(:stdout) { should eq 'disabled' }
end

describe command('svcs -Ho state pkgsrc/php-fpm') do
  its(:stdout) { should eq 'disabled' }
end

describe command('svcs -Ho state pkgsrc/nginx') do
  its(:stdout) { should eq 'disabled' }
end

describe command('svcs -Ho state pkgsrc/memcached') do
  its(:stdout) { should eq 'disabled' }
end

describe command('svcs -Ho state pkgsrc/chef-client') do
  its(:stdout) { should eq 'disabled' }
end

describe command('svcs -Ho state pkgsrc/mailman') do
  its(:stdout) { should eq 'disabled' }
end

describe command('svcs -Ho state pkgsrc/lighttpd') do
  its(:stdout) { should eq 'disabled' }
end

describe command('svcs -Ho state pkgsrc/courier-imap') do
  its(:stdout) { should eq 'disabled' }
end

describe command('svcs -Ho state pkgsrc/courier-authlib') do
  its(:stdout) { should eq 'disabled' }
end
