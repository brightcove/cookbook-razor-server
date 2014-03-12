# encoding: UTF-8
#
# Cookbook Name:: razor-server
# Recipe:: pkg

### Install PuppetLabs Repo
case node[:platform]
when 'ubuntu', 'debian'
  apt_repository 'Puppetlabs' do
		uri						'http://apt.puppetlabs.com'
		distribution	node[:lsb][:codename]
		components		['main', 'dependencies']
		key						'https://apt.puppetlabs.com/keyring.gpg'
		action :add
	end
# when 'centos', 'redhat'
# 	yum_repository 'puppetlabs' do
# 		description ''
# 		baseurl			''
# 		gpgkey			'https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs'
# 		action :create
# 	end
end

### Install Razor package (which pulls in most deps)
package 'razor-server'

service 'razor-server' do
  action [:enable, :start]
end

template "#{node[:razor][:config][:dest]}/config.yaml" do
  source 'config.yaml.erb'
  owner node[:razor][:user]
  group node[:razor][:group]
  mode  00660
end

# Support custom brokers and tasks outside the pkg managed folder
%w[ brokers tasks ].each do |dir|
  directory "#{node[:razor][:config][:dest]}/#{dir}" do
    path  "#{node[:razor][:config][:dest]}/#{dir}"
    owner node[:razor][:user]
    group node[:razor][:group]
  end 
end

execute 'Create/Migrate database' do
  command 'razor-admin -e production migrate-database'
  path    ['/usr/local/bin']
  cwd     node[:razor][:install][:dest]
  action  :nothing
  subscribes :run, "template[#{node[:razor][:config][:dest]}/config.yaml]", :immediately
end

#ark 'razor-microkernel' do
##  url   node[:razor][:microkernel][:url]
#  url   'file:///tmp/razor-microkernel.tar.gz'
#  path  "#{node[:razor][:install][:repo]}/"
#  owner node[:razor][:user]
#  group node[:razor][:group]
#  action :put
#end

execute 'wget razor-microkernel' do
  command "wget #{node[:razor][:microkernel][:url]} -O /tmp/razor-microkernel.tar"
  creates '/tmp/razor-microkernel.tar'
end

execute 'untar razor-microkernel' do
  command "tar -xvf /tmp/razor-microkernel.tar -C #{node[:razor][:install][:repo]}/"
  creates "#{node[:razor][:install][:repo]}/microkernel"
end

if node[:razor][:tftp]
  include_recipe 'razor-server::tftp'
end

if node[:razor][:dhcp]
  include_recipe 'razor-server::dhcp'
end
