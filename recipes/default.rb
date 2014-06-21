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

# A few additional prerequisites before attempting 
# to install hiverunner via pip.  The version of 
# distribute needs to be updated to install the dependencies.

remote_file "#{Chef::Config[:file_cache_path]}/distribute_setup.py" do
  source "http://python-distribute.org/distribute_setup.py"
  mode '0644'
  notifies :run, "bash[install_distribute]", :immediately
  not_if do 
    File.exists?("#{hiverunner_dir}/bin/hiverunner")
  end
end

bash 'install_distribute' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
   . #{hiverunner_dir}/bin/activate
   python distribute_setup.py
  EOF
  action :nothing
end

# Make sure the required packages are installed for the MySQL-python dependency
pkgs_for_MySQL_python = %w{ libmysqlclient-dev python-dev }
pkgs_for_MySQL_python.each do |pkg|
  package pkg do
    action :install
  end
end

# install hiverunner using pip
python_pip "hiverunner" do
  virtualenv hiverunner_dir
  action :install
end



hiverunner_cmd = %Q{ source #{hiverunner_dir}/bin/activate; hiverunner --FREQ \
    --mysql-host mysql01.example.com \
    --mysql-database beeswax \
    --mysql-user hue \
    --mysql-password secret \
    --hive-host hive01.example.com \
    --memcache-host cache01.example.com }

# Set cron jobs to run

# Hourly
cron "hiverunner_hourly" do
  user 'hiverunner'
  minute "0"
  command hiverunner_cmd.gsub("FREQ", "hourly")
end

# Daily - Will run just past midnight, 
# but run at 20 min past the hour to space 
# it out from the hourly job
cron "hiverunner_daily" do
  user 'hiverunner'
  minute "20"
  hour "0"
  command hiverunner_cmd.gsub("FREQ", "daily")
end

# Weekly - run after midnight on Sundays
# but run at 40 min past the hour to space
# it out from the hourly and daily jobs
cron "hiverunner_weekly" do
  user 'hiverunner'
  minute "40"
  hour "0"
  weekday "0"
  command hiverunner_cmd.gsub("FREQ", "weekly")
end
