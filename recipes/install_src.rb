#
# Cookbook:: cas_haproxy
# Recipe:: install_src
# Description:: Install HAProxy from source
#

# Break up HAProxy version
version = node['cas_haproxy']['version']
version_major, version_minor, version_patch = version.split('.')
