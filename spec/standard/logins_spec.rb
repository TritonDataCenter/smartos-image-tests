require 'spec_helper'

# Do all the logins work that are set via the API?

## MySQL
describe command("mysql -uroot -p$(mdata-get mysql_pw) -e 'select version();' ") do
	its(:exit_status) { should eq 0 }
end

## Postgres

# Need to enable the service first
describe command('svcadm enable postgresql') do
  its(:exit_status) { should eq 0 }
	# Test login
	describe command('PGPASSWORD="$(mdata-get pgsql_pw)" psql -U postgres -c "select version();"') do
	   its(:exit_status) { should eq 0 }
	end
end

# Test login
#describe command('PGPASSWORD="$(mdata-get pgsql_pw)" psql -U postgres -c "select version();"') do
#  its(:exit_status) { should eq 0 }
#end

# disable service
describe command('svcadm disable postgresql') do
  its(:exit_status) { should eq 0 }
end
