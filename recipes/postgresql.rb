# encoding: UTF-8
#
# Cookbook Name:: razor_server
# Recipe:: postgresql

include_recipe 'postgresql::server'

include_recipe 'database'
include_recipe 'database::postgresql'

postgresql_connection_info = {
  host: 'localhost',
  port: node['postgresql']['config']['port'],
  username: 'postgres',
  password: node['postgresql']['password']['postgres']
}

postgresql_database_user node[:razor][:database][:user] do
  connection postgresql_connection_info
  password   node[:razor][:database][:pass]
  action     :create
end

postgresql_database node[:razor][:database][:name] do
  connection postgresql_connection_info
  template 'DEFAULT'
  encoding 'UTF-8'
  tablespace 'DEFAULT'
  connection_limit '-1'
  owner node[:razor][:database][:user]
  action :create
end
