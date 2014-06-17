#
# Cookbook Name:: razor_server
# Recipe:: ui
#
# Copyright 2014, Brightcove, Inc
#
# All rights reserved - Do Not Redistribute
#

# Install NGINX
include_recipe "nginx::default"
include_recipe "nginx::http_stub_status_module"

# Download and Extract the Razor UI
ark "razor-ui" do
  path      node['razor-ui']['install']['base']
  url       node['razor-ui']['install']['url']
  extension "tar.gz"
  owner  node['nginx']['user']
  group  node['nginx']['group']
  action    :put
end

# Setup the site config
template "razor-ui" do
	path   "#{node['nginx']['dir']}/sites-available/razor-ui"
  source "razor-ui.nginx.erb"
  mode   0660
  owner  node['nginx']['user']
  group  node['nginx']['group']
end

# Configure UI to Razor install
template "razor-ui cfg.js" do
	path   "#{node['razor-ui']['install']['dest']}/js/cfg.js"
  source "razor-ui.cfg.js.erb"
  mode   0660
  owner  node['nginx']['user']
  group  node['nginx']['group']
end

# Setup directory for logging
directory "/var/log/razor-ui" do
  owner  node['nginx']['user']
  group  node['nginx']['group']
end

# Enable the extracted UI
nginx_site "razor-ui"
