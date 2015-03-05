require 'spec_helper'

# Check to see if QuickBackup works
# see http://wiki.joyent.com/jpc2/Joyent+Quickbackup+for+Percona+MySQL+Server
describe command("quickbackup-percona backup") do
   its(:exit_status) { should eq 0 }
end
