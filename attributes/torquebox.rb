#
# Cookbook Name:: razor-server
# Attributes:: torquebox

node.default[:razor][:torquebox][:version] = "3.0.2"
node.default[:razor][:torquebox][:checksum] = "a40abe4a7e71c65c599bed3c3717f5aca5f898dbb683c3940e1ca404eabf2b56"
node.default[:razor][:torquebox][:url]  = "http://torquebox.org/release/org/torquebox/torquebox-dist/#{node[:razor][:torquebox][:version]}/torquebox-dist-#{node[:razor][:torquebox][:version]}-bin.zip"
node.default[:razor][:torquebox][:root] = "torquebox-#{node[:razor][:torquebox][:version]}"
node.default[:razor][:torquebox][:base] = '/opt'
node.default[:razor][:torquebox][:dest] = '/opt/razor-torquebox'
node.default[:razor][:torquebox][:user] = node[:razor][:user]
node.default[:razor][:torquebox][:group] = node[:razor][:group]

