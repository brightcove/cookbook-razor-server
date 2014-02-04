#
# Cookbook Name:: razor-server
# Attributes:: razor-server

node.default[:razor][:name] = node[:fqdn]
node.default[:razor][:user] = "razor-server"
node.default[:razor][:group] = "razor-server"

node.default[:razor][:dhcp][:enable] = true
node.default[:razor][:tftp][:enable] = true

node.default[:razor][:url] = "http://links.puppetlabs.com/razor-server-latest.zip"
node.default[:razor][:base] = "/opt"
node.default[:razor][:dest] = "/opt/razor-server"
node.default[:razor][:repo] = "var/lib/razor/repo-store"

node.default[:razor][:microkernel][:version] = "004"
node.default[:razor][:microkernel][:url] = "https://github.com/puppetlabs/razor-el-mk/archive/release-#{node[:razor][:microkernel][:version]}.tar.gz"

node.default[:razor][:database][:name] = "razor-server"
node.default[:razor][:database][:user] = "razor-server"
node.default[:razor][:database][:pass] = "razor-server"

node.default['postgresql']['version'] = 9.3
node.default['postgresql']['enable_pgdg_apt'] = true
node.default['postgresql']['password']['postgres'] = node[:razor][:database][:pass]

node.default[:postgresql][:pg_hba] = [
	{:comment => '# razor-server',:type => 'host', :db => node[:razor][:database][:name], :user => node[:razor][:database][:user], :addr => '127.0.0.1/32', :method => 'md5'},
	{:comment => '# postgres-local',:type => 'host', :db => 'template1', :user => 'postgres', :addr => '127.0.0.1/32', :method => 'md5'}
]

node.default[:razor][:dhcp][:subnet]  = "192.168.10.0"
node.default[:razor][:dhcp][:netmask] = "255.255.255.0"
node.default[:razor][:dhcp][:range]   = "range 192.168.10.200 192.168.10.250"
node.default[:razor][:dhcp][:options] = [ "if exists user-class and option user-class = \"iPXE\" {
    filename \"bootstrap.ipxe\";
  } else {
    filename \"undionly.kpxe\";
  }"
] 

node.default[:dhcp][:networks] = [ "192.168.10.0/24" ] 

case node[:platform]
when "ubuntu","debian"
  node.default[:razor][:libarchive] = "libarchive12"
when "centos","redhat"
  node.default[:razor][:libarchive] = "libarchive-devel"
end


