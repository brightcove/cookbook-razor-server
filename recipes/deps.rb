# encoding: UTF-8
#
# Cookbook Name:: razor_server
# Recipe:: deps

# Due to Postgresql cookbook not playing nice
execute 'apt-get-update' do
  command 'apt-get update'
  ignore_failure true
#  only_if { apt_installed? }
  only_if { platform_family?("debian") }
  not_if do
    ::File.exists?('/var/lib/apt/periodic/update-success-stamp') &&
      ::File.mtime('/var/lib/apt/periodic/update-success-stamp') < Time.now - 86400
  end
end.run_action(:run)

include_recipe 'apt'
include_recipe 'build-essential'

package node[:razor][:libarchive]

package 'unzip'
package 'curl'
package 'ipmitool'

if node[:razor][:source]
  # Install Java
  include_recipe 'java'
  
  group node[:razor][:group]
  
  user node[:razor][:user] do
    group node[:razor][:group]
    system true
    password '*'
    home node[:razor][:torquebox][:dest]
    shell '/bin/bash'
    comment 'razor_server daemon user'
  end
end

include_recipe 'razor_server::postgresql'
