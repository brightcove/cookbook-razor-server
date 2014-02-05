#
# Cookbook Name:: razor-server
# Attributes:: torquebox

node.default[:razor][:torquebox][:version] = "3.0.1"
node.default[:razor][:torquebox][:checksum] = "fd385d44619cb56d4c076c67243b0dfc4dab30145226d7f584517f1a8891cb18"
node.default[:razor][:torquebox][:url]  = "http://torquebox.org/release/org/torquebox/torquebox-dist/#{node[:razor][:torquebox][:version]}/torquebox-dist-#{node[:razor][:torquebox][:version]}-bin.zip"
node.default[:razor][:torquebox][:root] = "torquebox-#{node[:razor][:torquebox][:version]}"
node.default[:razor][:torquebox][:base] = '/opt'
node.default[:razor][:torquebox][:dest] = '/opt/razor-torquebox'
node.default[:razor][:torquebox][:user] = node[:razor][:user]
node.default[:razor][:torquebox][:group] = node[:razor][:group]

