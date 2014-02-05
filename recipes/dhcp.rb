# encoding: UTF-8
#
# Cookbook Name:: razor-server
# Recipe:: dhcp

include_recipe 'dhcp::server'

dhcp_subnet node[:razor][:dhcp][:subnet] do
  range node[:razor][:dhcp][:range]
  netmask node[:razor][:dhcp][:netmask]
  options node[:razor][:dhcp][:options]
  routers node[:razor][:dhcp][:routers]
end
