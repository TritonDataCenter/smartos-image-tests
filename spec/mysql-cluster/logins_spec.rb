require 'spec_helper'

# Check to see if MySQL root password works
describe command("svcadm enable -s pkgsrc/mysql-cluster:mysqld && while [[ ! -e /tmp/mysql.sock ]]; do sleep 2; done") do
   its(:exit_status) { should eq 0 }
end

describe command("mysql -uroot -p$(mdata-get mysql_pw) -e 'select version();'") do
   its(:exit_status) { should eq 0 }
end
