# encoding: UTF-8
#
# Cookbook Name:: razor-server
# Recipe:: default

gem_package "razor-client" do
  action :install
end
