require 'spec_helper'

## Since 13.2.1
if property[:base_version].delete('.').to_i >= 1321
	# Make sure PHP is enabled
	describe file('/opt/local/etc/httpd/httpd.conf') do
  	it { should be_file }
  	it { should contain "LoadModule php5_module lib/httpd/mod_php5.so" }
  	it { should contain "AddHandler php5-script .php" }
	end

	# Make sure PHP settings are enabled
	describe file('/opt/local/etc/php.ini') do
  	it { should be_file }
		it { should contain "extension=ZendOptimizerPlus.so" } # Replaced APC in PHP 5.5
		it { should contain "extension=curl.so" }
		it { should contain "extension=dom.so" }
		it { should contain "extension=gd.so" }
		it { should contain "extension=iconv.so" }
		it { should contain "extension=json.so" }
		it { should contain "extension=mbstring.so" }
		it { should contain "extension=mcrypt.so" }
		it { should contain "extension=mysql.so" }
		it { should contain "extension=mysqli.so" }
		it { should contain "extension=xmlrpc.so" }
		it { should contain "extension=xsl.so" }
		it { should contain "extension=zlib.so" }
	end
end

# Make sure mysql is listening on the 127.0.0.1
describe file('/opt/local/etc/my.cnf') do
  it { should be_file }
  it { should contain "bind-address = 127.0.0.1" }
end
