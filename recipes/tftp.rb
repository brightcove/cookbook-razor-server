

include_recipe "tftp::server"

cookbook_file "undionly.kpxe" do
  owner [:tftp][:username]
  group node[:razor][:group]
  path "#{node[:tftp][:directory]}/undionly.kpxe"
end

template "bootstrap.ipxe" do
  owner [:tftp][:username]
  group node[:razor][:group]
  path "#{node[:tftp][:directory]}/bootstrap.ipxe"
end
