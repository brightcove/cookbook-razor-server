# encoding: UTF-8
#
# Cookbook Name:: razor-server
# Recipe:: default

include_recipe 'razor-server::deps'

if node[:razor][:source]
  include_recipe 'razor-server::src-server'
else
  include_recipe 'razor-server::pkg'
end

include_recipe 'razor-server::ui'
