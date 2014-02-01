

include_recipe "tftp::server"

cookbook_file "undionly.kpxe" do
  owner node[:razor][:user]
  group node[:razor][:group]
  path "#{node[:tftp][:directory]}/undionly.kpxe"
end

template "bootstrap.ipxe" do
  owner node[:razor][:user]
  group node[:razor][:group]
  path "#{node[:tftp][:directory]}/bootstrap.ipxe"
end
