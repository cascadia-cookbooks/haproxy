#
# Cookbook:: cas_haproxy
# Recipe:: install_src
# Description:: Install HAProxy from source
#

# Break up HAProxy version
version_major, version_minor, version_patch = node['cas_haproxy']['version'].split('.')
