#
# Cookbook Name:: razor-server
# Recipe:: torquebox
#

ark "torquebox" do
  url   node[:razor][:torquebox][:url]
  path  node[:razor][:torquebox][:dest]
  owner node[:razor][:torquebox][:user]
  group node[:razor][:torquebox][:group]
  mode 00755
  action :install
end

directory "#{node[:razor][:torquebox][:dest]}/jboss/standalone" do
  owner node[:razor][:torquebox][:user]
  group node[:razor][:torquebox][:group]
  action :modify
end

directory "/var/log/razor-server" do
  owner node[:razor][:torquebox][:user]
  group "root"
  mode  00755
end

template "/etc/init.d/razor-server" do
  source "razor-server.init.erb"
  owner "root"
  group "root"
  mode  00755
  variables({
    :dest => node[:razor][:torquebox][:dest],
    :user => node[:razor][:torquebox][:user]
  })
end

service "razor-server" do
  action [:enable, :start]
end
  
