#
# Cookbook Name:: razor-server
# Attributes:: razor-server

node.default[:razor][:name] = node[:fqdn]
node.default[:razor][:user] = "razor-server"
node.default[:razor][:group] = "razor-server"

node.default[:razor][:dhcp] = true
node.default[:razor][:tftp] = true

node.default[:razor][:url] = "http://links.puppetlabs.com/razor-server-latest.zip"
node.default[:razor][:dest] = "/opt/razor"
node.default[:razor][:repo] = "var/lib/razor/repo-store"
node.default[:razor][:microkernel][:url] = "http://links.puppetlabs.com/razor-microkernel-latest.tar"

node.default[:razor][:database][:name] = "razor-server"
node.default[:razor][:database][:user] = "razor-server"
node.default[:razor][:database][:pass] = "razor-server"

node['postgresql']['pg_hba'] = [
	{:comment => '# razor-server',:type => 'tcp', :db => node[:razor][:database][:name], :user => node[:razor][:database][:user], :addr => nil, :method => 'md5'}
]

node.default[:razor][:dhcp][:subnet]  = "192.168.1.0"
node.default[:razor][:dhcp][:netmask] = "255.255.255.0"
node.default[:razor][:dhcp][:range]   = "range 192.168.1.200 192.168.1.250"
node.default[:razor][:dhcp][:options] = [ "if exists user-class and option user-class = \"iPXE\" {
    filename \"bootstrap.ipxe\";
  } else {
    filename \"undionly.kpxe\";
  }"  ] 

case node[:platform]
when "ubuntu","debian"
  node.default[:razor][:libarchive] = "libarchive"
when "centos","redhat"
  node.default[:razor][:libarchive] = "libarchive-devel"
end


