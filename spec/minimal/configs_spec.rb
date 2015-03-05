require 'spec_helper'

## Version specfiic tests
#
## Since 13.3.1. See IMAGE-437
if property[:base_version].delete('.').to_i >= 1331
  # Platform regression in 13.3.0. default locale was not set to "C"
  # See DATASET-940.
  describe file('/etc/default/init') do
    it { should contain "LANG=C" }
  end
  
  # Platform regression in 13.3.0, /etc/shells was missing
  # See IMAGE-435
	describe file('/etc/shells') do
		it { should be_file }
	end
  
  # Platform regression. /etc/issue should not exist.
  # See IMAGE-433
	describe command('ls /etc/issue') do
		its(:stderr) { should match /No such file or directory/ }
	end
end


## Since 13.3.0. See IMAGE-404
if property[:base_version].delete('.').to_i >= 1330
  # See DATASET-937
  # datasets should ship with /etc/ipadm/ipadm.conf
  describe file('/etc/ipadm/ipadm.conf') do
    it { should be_file }
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

  #  See IMAGE-404
  #  rsyslog not built with mysql and pgsql support to prevent package conflicts
  # guardtime was removed in 14.2.0
  version = property[:base_version].delete('.').to_i
  
  if version < 1430
  	describe command('pkg_info -Q PKG_OPTIONS rsyslog') do
    	it { should return_stdout 'file libgcrypt solaris uuid' }
		end	

  end
  
  if version < 1420
		describe command('pkg_info -Q PKG_OPTIONS rsyslog') do
			it { should return_stdout 'file guardtime libgcrypt solaris uuid' }	
		end

  	# with  mysql and pgsql support, return value would be
  	# 'file guardtime libgcrypt mysql pgsql solaris uuid'
  end

  # See DATASET-602
  # Bash auto-completion support for pkgin
  describe file('/etc/bash/bash_completion.d/pkg') do
    it { should be_file }
    its(:md5sum) { should eq '056b06078621a401d4f81d3d1f0260fc' }
  end

  # See DATASET-837
  # Note here that starting with base 13.3.0, there will be a XAuthLocation 
  # pre-set to the /opt/local/bin/xauth path, in /etc/ssh/sshd_config.
  describe file('/etc/ssh/sshd_config') do
    it { should be_file }
    it { should contain "XAuthLocation /opt/local/bin/xauth" }
  end
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
if property[:base_version].delete('.').to_i >= 1310
  describe file('/var/log/authlog') do
  	it { should be_file }
  end

  describe file('/var/log/maillog') do
    it { should be_file }
  end

  describe file('/etc/syslog.conf') do
  	it { should be_file }
    it { should contain "/var/log/authlog" }
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
end

# 2015-03-04
# For newer releases we default to rsyslog. If we modify /etc/syslog.conf in anyway
# the syslog init script checksum will fail, setting syslog as the default
if property[:base_version].delete('.').to_i < 1440
  describe file('/etc/syslog.conf') do
  	it { should be_file }
    it { should contain "/var/log/maillog" }
  end
end
