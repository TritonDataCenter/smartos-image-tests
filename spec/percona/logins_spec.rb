require 'spec_helper'

# Check to see if MySQL root password works
describe command("mysql -uroot -p$(mdata-get mysql_pw) -e 'select version();' ") do
   it { should return_exit_status 0 }
end
