#
# Cookbook:: cas_haproxy
# Recipe:: install
# Description:: Install HAProxy from OS repository
#

if node['cas_haproxy']['version'] == 'pkg'
    # Installation default OS package manager version
    package 'haproxy'
else
    # pass
end
