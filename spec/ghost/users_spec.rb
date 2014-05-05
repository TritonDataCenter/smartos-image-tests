describe user('ghost') do
  it { should exist }
  it { should belong_to_group 'ghost' }
  it { should have_home_directory '/home/ghost' }
  it { should have_login_shell '/usr/bin/bash' }
end
