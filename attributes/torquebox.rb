#
# Cookbook Name:: razor-server
# Attributes:: torquebox

node.default[:razor][:torquebox][:url]  = 'http://torquebox.org/release/org/torquebox/torquebox-dist/3.0.1/torquebox-dist-3.0.1-bin.zip'
node.default[:razor][:torquebox][:root] = 'torquebox-3.0.1'
node.default[:razor][:torquebox][:dest] = '/opt/razor-torquebox'
node.default[:razor][:torquebox][:user] = node[:razor][:user]
node.default[:razor][:torquebox][:group] = node[:razor][:group]

