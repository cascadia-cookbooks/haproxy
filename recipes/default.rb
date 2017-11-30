#
# Cookbook:: haproxy
# Recipe:: default
# Description:: Manages HAProxy
#

include_recipe 'cas_haproxy::install'
include_recipe 'cas_haproxy::configure'
