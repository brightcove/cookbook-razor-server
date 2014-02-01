#
# Cookbook Name:: razor-server
# Attributes:: razor-server

node.default[:razor][:name] = node[:fqdn]
node.default[:razor][:user] = "razor-server"
node.default[:razor][:group] = "razor-server"
node.default[:razor][:tftp] = true

node.default[:razor][:url] = "http://links.puppetlabs.com/razor-server-latest.zip"
node.default[:razor][:dest] = "/opt/razor"

case node[:platform]
when "ubuntu","debian"
  node.default[:razor][:libarchive] = "libarchive"
when "centos","redhat"
  node.default[:razor][:libarchive] = "libarchive-devel"
end


