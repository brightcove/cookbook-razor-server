# encoding: UTF-8
#
# Cookbook Name:: razor-server
# Recipe:: dhcp

include_recipe 'dhcp::server'

dhcp_subnet node[:razor][:dhcp][:subnet] do
  netmask node[:razor][:dhcp][:netmask]
  range   node[:razor][:dhcp][:range]
  broadcast node[:razor][:dhcp][:broadcast]
  options node[:razor][:dhcp][:options]
  routers node[:razor][:dhcp][:routers]
  evals   node[:razor][:dhcp][:evals]
end
