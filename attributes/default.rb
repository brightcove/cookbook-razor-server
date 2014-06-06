# encoding: UTF-8
#
# Cookbook Name:: razor_server
# Attributes:: razor_server

# TODO: Need to alert mailing list before default shift to package based install
# By default, install the PuppetLabs repo and pkgs
default[:razor][:source] = true

# When DNS is available / already registered
default[:razor][:name] = node[:fqdn]

# When DNS is NOT available, use direct IP
# default[:razor][:name] = '192.168.10.2'

default[:razor][:user] = 'razor'
default[:razor][:group] = 'razor'

default[:razor][:dhcp][:enable] = true
default[:razor][:tftp][:enable] = true

default[:razor][:microkernel][:version] = '004'
default[:razor][:microkernel][:url] = "http://links.puppetlabs.com/razor-microkernel-#{node[:razor][:microkernel][:version]}.tar"

default[:razor][:database][:name] = 'razor'
default[:razor][:database][:user] = 'razor'
default[:razor][:database][:pass] = 'razor'

# Let the user decide what version and if to use PGDG repos
#normal[:postgresql][:version] = 9.3
#normal[:postgresql][:enable_pgdg_apt] = true
#normal[:postgresql][:enable_pgdg_yum] = true

if Chef::Config[:solo]
  # The postgresql cookbook requires the password set when in Chef Solo
  default[:postgresql][:password][:postgres] = node[:razor][:database][:pass]
end

default[:postgresql][:pg_hba] = [
	{:type => 'local', :db => 'all', :user => 'postgres', :addr => nil, :method => 'ident'},
	{:type => 'local', :db => 'all', :user => 'all', :addr => nil, :method => 'ident'},
	{:type => 'host', :db => 'all', :user => 'all', :addr => '127.0.0.1/32', :method => 'md5'},
	{:type => 'host', :db => 'all', :user => 'all', :addr => '::1/128', :method => 'md5'},
	{:comment => '# razor', :type => 'host', :db => node[:razor][:database][:name], :user => node[:razor][:database][:user], :addr => '127.0.0.1/32', :method => 'md5' },
	{:comment => '# postgres-local', :type => 'host', :db => 'template1', :user => 'postgres', :addr => '127.0.0.1/32', :method => 'md5' }
]

normal[:dhcp][:use_bags] = false
default[:razor][:dhcp][:subnet]  = '192.168.10.0'
default[:razor][:dhcp][:netmask] = '255.255.255.0'
default[:razor][:dhcp][:broadcast] = '192.168.10.255'
default[:razor][:dhcp][:range]   = '192.168.10.200 192.168.10.250'
default[:razor][:dhcp][:options] = [ "next-server 192.168.10.2" ]
default[:razor][:dhcp][:evals] = [%Q{
  if exists user-class and option user-class = "iPXE" {
    filename "bootstrap.ipxe";
  } else {
    filename "undionly.kpxe";
  }
}]

# Razor UI (masteinhauser version)
default["razor-ui"][:port] = "80" # ~FC019
default["razor-ui"][:install][:url]  = "https://codeload.github.com/masteinhauser/razor-ui/legacy.tar.gz/master" # ~FC019
default["razor-ui"][:install][:base] = "/opt" # ~FC019
default["razor-ui"][:install][:dest] = "/opt/razor-ui" # ~FC019

# Install from Source options
default[:razor][:config][:dest] = '/etc/razor'
default[:razor][:install][:version] = '0.14.1'
default[:razor][:install][:url] = "https://github.com/puppetlabs/razor-server/archive/#{node[:razor][:install][:version]}.zip"
default[:razor][:install][:base] = '/opt'
default[:razor][:install][:dest] = '/opt/razor'
default[:razor][:install][:repo] = '/var/lib/razor/repo-store'

case node[:platform]
when 'ubuntu', 'debian'
  default[:razor][:libarchive] = 'libarchive-dev'
when 'centos', 'redhat'
  default[:razor][:libarchive] = 'libarchive-devel'
end
