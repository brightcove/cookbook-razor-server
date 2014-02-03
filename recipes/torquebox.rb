#
# Cookbook Name:: razor-server
# Recipe:: torquebox
#

execute "wget torquebox" do
  command "wget #{node[:razor][:torquebox][:url]} -O /tmp/torquebox.zip"
end

ark "razor-torquebox" do
  version  node[:razor][:torquebox][:version]
  checksum node[:razor][:torquebox][:checksum]
#  url      node[:razor][:torquebox][:url]
  url      "file:///tmp/torquebox.zip"
  path     node[:razor][:torquebox][:base]
  owner    node[:razor][:torquebox][:user]
  group    node[:razor][:torquebox][:group]
  mode     00755
#  action   :install
  action   :put
  strip_leading_dir true
  has_binaries ["jruby/bin/jruby"]
end

directory "#{node[:razor][:torquebox][:dest]}/jboss/standalone" do
  owner node[:razor][:torquebox][:user]
  group node[:razor][:torquebox][:group]
  recursive true
end

directory "/var/log/razor-server" do
  owner node[:razor][:torquebox][:user]
  group "root"
  mode  00755
  recursive true
end

template "/etc/init.d/razor-server" do
  source "razor-server.init.erb"
  owner "root"
  group "root"
  mode  00755
  variables(
    :dest => node[:razor][:torquebox][:dest],
    :user => node[:razor][:torquebox][:user]
  )
end

service "razor-server" do
  action [:enable, :start]
end
  
