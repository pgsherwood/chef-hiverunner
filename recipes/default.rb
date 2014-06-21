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
