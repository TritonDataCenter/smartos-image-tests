require 'spec_helper'

# Test login to posgres works
describe command('PGPASSWORD="$(mdata-get pgsql_pw)" psql -U postgres -c "select version();"') do
  its(:exit_status) { should eq 0 }
end
