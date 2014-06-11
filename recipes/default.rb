# encoding: UTF-8
#
# Cookbook Name:: razor_server
# Recipe:: default

include_recipe 'razor_server::deps'

if node['razor']['source']
  include_recipe 'razor_server::src-server'
else
  include_recipe 'razor_server::pkg'
end

include_recipe 'razor_server::ui'
