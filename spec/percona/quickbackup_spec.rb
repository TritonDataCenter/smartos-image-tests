require 'spec_helper'

# Check to see if QuickBackup works
# see http://wiki.joyent.com/jpc2/Joyent+Quickbackup+for+Percona+MySQL+Server
describe command("quickbackup-percona backup") do
   it { should return_exit_status 0 }
end
