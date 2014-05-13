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
  it { should return_stdout 'disabled' }
end

describe command('svcs -Ho state pkgsrc/php-fpm') do
  it { should return_stdout 'disabled' }
end

describe command('svcs -Ho state pkgsrc/nginx') do
  it { should return_stdout 'disabled' }
end

describe command('svcs -Ho state pkgsrc/memcached') do
  it { should return_stdout 'disabled' }
end

describe command('svcs -Ho state pkgsrc/chef-client') do
  it { should return_stdout 'disabled' }
end

describe command('svcs -Ho state pkgsrc/mailman') do
  it { should return_stdout 'disabled' }
end

describe command('svcs -Ho state pkgsrc/lighttpd') do
  it { should return_stdout 'disabled' }
end

describe command('svcs -Ho state pkgsrc/courier-imap') do
  it { should return_stdout 'disabled' }
end

describe command('svcs -Ho state pkgsrc/courier-authlib') do
  it { should return_stdout 'disabled' }
end
