#
# Cookbook Name:: razor-server
# Recipe:: server

# Razor likes to run on top of their Torquebox design
include_recipe "razor-server::torquebox"

ark "razor-server" do
  url   node[:razor][:url]
  path  node[:razor][:dest]
  owner node[:razor][:user]
  group node[:razor][:group]
  mode 00755
  action :install
end

execute "Deploy razor into torquebox" do
  command "#{node[:razor][:torquebox][:dest]}/jruby/bin/torquebox deploy --env production"
  creates "#{node[:razor][:torquebox][:dest]}/jboss/standalone/deployments/razor-knob.yml"
  environment(
    "TORQUEBOX_HOME" => node[:razor][:torquebox][:dest],
    "JBOSS_HOME" => "#{node[:razor][:torquebox][:dest]}/jboss",
    "JRUBY_HOME" => "#{node[:razor][:torquebox][:dest]}/jruby"
  )
  path  "#{node[:razor][:torquebox][:dest]}/jruby/bin:/bin:/usr/bin:/usr/local/bin"
end

template "#{node[:razor][:torquebox][:dest]}/bin/razor-binary-wrapper" do
  source "razor-binary-wrapper.erb"
  owner  "root"
  group  "root"
  mode   00755
end

link "/usr/local/bin/razor-admin" do
  to "#{node[:razor][:torquebox][:dest]}/bin/razor-binary-wrapper"
end

file "#{node[:razor][:torquebox][:dest]}/bin/razor-admin" do
  mode  00755
end

directory "/var/lib/razor/repo-store" do
  owner node[:razor][:user]
  group node[:razor][:group]
  recursive true
  mode  00755
  action :create
end

directory "#{node[:razor][:torquebox][:dest]}/log" do
  owner node[:razor][:user]
  group node[:razor][:group]
  mode  00755
end

file "#{node[:razor][:torquebox][:dest]}/log/production.log" do
  owner node[:razor][:user]
  group node[:razor][:group]
  mode  00660
end

if node[:razor][:tftp]
  indclude_recipe "razor-server::tftp"
end

if node[:razor][:dhcp]
  include_recipe "razor-server::dhcp"
end
