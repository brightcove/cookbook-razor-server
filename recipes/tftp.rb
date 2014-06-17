# encoding: UTF-8

include_recipe 'tftp::server'

cookbook_file 'undionly.kpxe' do
  owner node['tftp']['username']
  group node['razor']['group']
  path "#{node['tftp']['directory']}/undionly.kpxe"
end

template 'bootstrap.ipxe' do
  owner node['tftp']['username']
  group node['razor']['group']
  path "#{node['tftp']['directory']}/bootstrap.ipxe"
end
