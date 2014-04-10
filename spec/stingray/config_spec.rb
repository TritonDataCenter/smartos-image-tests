require 'spec_helper'


# Since 13.4.0. IMAGE-447
describe file('/opt/local/stingray/zxtm/conf/settings.cfg') do
  it { should be_file }
	# IMAGE-411 Java Extensions enabled
	it { should contain 'java!enabled    Yes' }
	# Added setting "webcache!max_file_size 25MB" to zxtm configuration
	it { should contain('25MB').after(/^webcache!max_file_size/) }
end


# IMAGE-430 missing directory on stingray images interferes with importing \
# backups via the webUI

if attr[:name] == "stm-developer"
	# stm-developer has Stingray 9.6
  describe file('/opt/local/stingray/zxtm-9.6/.backup/') do
    it { should be_directory }
  end
else
	# All other 13.4.1 versions have 9.5
  describe file('/opt/local/stingray/zxtm-9.5/.backup/') do
    it { should be_directory }
  end
  
end


