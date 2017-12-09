#
# Cookbook:: haproxy
# Recipe:: default
# Description:: Manages HAProxy
#

if node['cas_haproxy']['version'] == 'pkg'
    include_recipe 'cas_haproxy::install_pkg'
else
    include_recipe 'cas_haproxy::install_src'
end

include_recipe 'cas_haproxy::configure'
