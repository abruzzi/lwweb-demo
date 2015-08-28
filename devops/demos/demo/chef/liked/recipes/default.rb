#
# Cookbook Name:: liked
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#


group node['liked']['group'] 

user node['liked']['user'] do
    group node['liked']['group']
    supports :manage_home => true
	shell "/bin/bash"
	home "/home/liked"
	system true
	action :create
    password '$1$FkQYIc6r$zWStDmKuCELS6shYkWYXJ.'
end

include_recipe 'nginx'

# generate nginx configuration
template "#{node['nginx']['dir']}/sites-enabled/#{node['liked']['config']}" do
	source "liked.conf.erb"
	notifies :restart, "service[nginx]"
end

# create application folder
directory "#{node['liked']['app_root']}" do
	action :create
	owner node['liked']['user']
	recursive true
end

include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

rbenv_ruby "#{node['liked']['rbenv']['version']}" do
	global true
end

rbenv_gem "bundler" do
  ruby_version "#{node['liked']['rbenv']['version']}"
end