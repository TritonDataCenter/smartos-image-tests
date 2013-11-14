require 'spec_helper'

## Version specfiic tests for regressions

## Since 13.3.0. See IMAGE-404

# Is this really 2013Q3?
describe file('/opt/local/etc/pkgin/repositories.conf') do
  it { should be_file }
  it { should contain "2013Q3" }
end

# Refactored SMF support; the likely only visible change is a different layout of SMF files on disk (see /opt/local/lib/svc)
describe file('/opt/local/lib/svc') do
  it { should be_directory }
end

# See DATASET-818
# The TCP stack buffers are tuned up for significantly better throughput 
describe file('/etc/rc2.d/S99net_tune') do
	it { should be_file }
  it { should be_mode 755 }
  it { should contain "ipadm set-prop -p send_maxbuf=128000 tcp" }
  it { should contain "padm set-prop -p recv_maxbuf=1048576 tcp" }
end

# See IMAGE-404
# Change in the default MANPATH, to prefer more commonly used tools in case of the identical man pages.
describe file('/root/.profile') do
	it { should be_file }
  it { should contain "MANPATH=/opt/local/man:/usr/share/man" }
  it { should contain "MANPATH=${MANPATH}:/opt/local/gcc47/man:/opt/local/java/sun6/man" }
  it { should contain "MANPATH=${MANPATH}:/opt/local/lib/perl5/man:/opt/local/lib/perl5/vendor_perl/man" }
end

# See IMAGE-353
# terminfo path set so that interactive sessions support the 256-color term types
# Not needed on SDC7 platforms
describe file('/root/.profile') do
	it { should be_file }
  it { should contain "TERMINFO=/opt/local/share/lib/terminfo" }
end

# See IMAGE-333
# Empty /usr/local path skelet pre-created to help some 3rd party software build/install gracefully, should it assume such paths exist ().

describe file('/usr/local') do
  it { should be_directory }
end


# See DATASET-602
# Bash auto-completion support for pkgin
describe file('/etc/bash/bash_completion.d/pkg') do
  it { should be_file }
  it { should match_md5checksum '056b06078621a401d4f81d3d1f0260fc' }
end

## Since 13.1.0 
# See IMAGE-219
#
# Restore SunOS original syslog locations
# /var/log/authlog instead of /var/log/auth.log
# /var/log/maillog instead of /var/log/postfix.log 
# Update the following with new lcoations
#  /etc/syslog.conf
#  /etc/rsyslog.conf
#  /etc/logadm.conf
# Change default logadm cron schedule to hourly for more granularity (DATASET-735).

describe file('/var/log/authlog') do
	it { should be_file }
end

describe file('/var/log/maillog') do
  it { should be_file }
end

describe file('/etc/syslog.conf') do
	it { should be_file }
  it { should contain "/var/log/authlog" }
  it { should contain "/var/log/maillog" }
end

describe file('/etc/rsyslog.conf') do
  it { should be_file }
  it { should contain  "/var/log/authlog" }
  it { should contain  "/var/log/maillog" }
end

describe file('/etc/logadm.conf') do
  it { should be_file }
  it { should contain "/var/log/maillog" }
end

describe cron do
  it { should have_entry('10 * * * * /usr/sbin/logadm').with_user('root') }
end
