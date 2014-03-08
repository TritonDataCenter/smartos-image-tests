require 'spec_helper'

# Test login to posgres works
describe command('PGPASSWORD="$(mdata-get pgsql_pw)" psql -U postgres -c "select version();"') do
  it { should return_exit_status 0 }
end
