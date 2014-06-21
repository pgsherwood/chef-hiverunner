#
# Cookbook Name:: hiverunner
# Recipe:: default
#
# Copyright (C) 2014 Greg Sherwood
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"

# Make sure packages are installed for running 'pip' and 'virtualenv'
pkgs_for_pip = %w{ python python-pip python-virtualenv }
pkgs_for_pip.each do |pkg|
  package pkg do
    action :install
  end
end

hiverunner_dir = node['hiverunner']['install_dir']

# create a hiverunner group and user 
# This will be used for the process permissions
# when running the hiverunner cron jobs rather
# than root
group "hiverunner" do
  system true
end

user "hiverunner" do
  comment 'Hiverunner User'
  gid 'hiverunner'
  system true
  shell '/bin/false'
end

directory hiverunner_dir do
  action :create
end

python_virtualenv hiverunner_dir do
  action :create
end

