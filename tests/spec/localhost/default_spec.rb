require 'spec_helper'

describe package('nginx'), :if => os[:family] == 'ubuntu' do
  it { should be_installed }
end

describe service('nginx'), :if => os[:family] == 'ubuntu' do
  it { should be_enabled }
  it { should be_running }
end

describe package('php7.0-fpm'), :if => os[:family] == 'ubuntu' do
  it { should be_installed }
end

describe service('php7.0-fpm'), :if => os[:family] == 'ubuntu' do
  it { should be_enabled }
  it { should be_running }
end

describe package('redis-server'), :if => os[:family] == 'ubuntu' do
  it { should be_installed }
end

describe service('redis-server'), :if => os[:family] == 'ubuntu' do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

describe port(6379) do
  it { should be_listening }
end
