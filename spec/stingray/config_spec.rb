require 'spec_helper'


# Since 13.4.0. IMAGE-447
describe file('/opt/local/stingray/zxtm/conf/settings.cfg') do
  it { should be_file }
	# IMAGE-411 Java Extensions enabled
	it { should contain "java!enabled Yes" }
	# Added setting "webcache!max_file_size 25MB" to zxtm configuration
	it { should contain "webcache!max_file_size 25MB" }
end


# IMAGE-430 missing directories on stingray images interferes with importing \
# backups via the webUI

describe file('/opt/local/stingray/zxtm-9.5/.backup/') do
  it { should be_directory }
end

describe file('/opt/local/stingray/zxtm-9.5/.backup/conf/') do
  it { should be_directory }
end

describe file('/opt/local/stingray/zxtm-9.5/.backup/log/') do
  it { should be_linked_to '/opt/local/stingray/zxtm-9.5/log/' }
end

