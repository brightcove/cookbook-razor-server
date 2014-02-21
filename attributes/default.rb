# encoding: UTF-8
#
# Cookbook Name:: razor-server
# Attributes:: razor-server

# When DNS is available / already registered
node.default[:razor][:name] = node[:fqdn]

# When DNS is NOT available, use direct IP
# node.default[:razor][:name] = '192.168.10.2'

node.default[:razor][:user] = 'razor-server'
node.default[:razor][:group] = 'razor-server'

node.default[:razor][:dhcp][:enable] = true
node.default[:razor][:tftp][:enable] = true

node.default[:razor][:install][:version] = '0.14.1'
node.default[:razor][:install][:url] = "https://github.com/puppetlabs/razor-server/archive/#{node[:razor][:install][:version]}.zip"
node.default[:razor][:install][:base] = '/opt'
node.default[:razor][:install][:dest] = '/opt/razor-server'
node.default[:razor][:install][:repo] = '/var/lib/razor/repo-store'

node.default[:razor][:microkernel][:version] = '004'
node.default[:razor][:microkernel][:url] = "http://links.puppetlabs.com/razor-microkernel-#{node[:razor][:microkernel][:version]}.tar"

node.default[:razor][:database][:name] = 'razor-server'
node.default[:razor][:database][:user] = 'razor-server'
node.default[:razor][:database][:pass] = 'razor-server'

#node.normal[:postgresql][:version] = 9.3
node.normal[:postgresql][:enable_pgdg_apt] = true # We want at least version 8.4+
node.normal[:postgresql][:enable_pgdg_yum] = true # We want at least version 8.4+
if Chef::Config[:solo] 
  node.default[:postgresql][:password][:postgres] = node[:razor][:database][:pass]
end

node.default[:postgresql][:pg_hba] = [
	{ comment: '# razor-server', type: 'host', db: node[:razor][:database][:name], user: node[:razor][:database][:user], addr: '127.0.0.1/32', method: 'md5' },
	{ comment: '# postgres-local', type: 'host', db: 'template1', user: 'postgres', addr: '127.0.0.1/32', method: 'md5' }
]

node.normal[:dhcp][:use_bags] = false
node.default[:razor][:dhcp][:subnet]  = '192.168.10.0'
node.default[:razor][:dhcp][:netmask] = '255.255.255.0'
node.default[:razor][:dhcp][:broadcast] = '192.168.10.255'
node.default[:razor][:dhcp][:range]   = '192.168.10.200 192.168.10.250'
node.default[:razor][:dhcp][:options] = [ "next-server 192.168.10.2" ]
node.default[:razor][:dhcp][:evals] = [%Q{
  if exists user-class and option user-class = "iPXE" {
    filename "bootstrap.ipxe";
  } else {
    filename "undionly.kpxe";
  }
}]

case node[:platform]
when 'ubuntu', 'debian'
  node.default[:razor][:libarchive] = 'libarchive-dev'
when 'centos', 'redhat'
  node.default[:razor][:libarchive] = 'libarchive-devel'
end
