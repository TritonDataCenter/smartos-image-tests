require 'spec_helper'

describe package('openjdk7') do
  it { should be_installed }
end

describe package('apache-cassandra') do
  it { should be_installed }
end
