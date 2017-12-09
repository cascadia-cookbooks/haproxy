#
# Cookbook:: cas_haproxy
# Recipe:: install_src
# Description:: Install HAProxy from source
#

# Break up HAProxy version
version = node['cas_haproxy']['version']
version_major, version_minor, version_patch = version.split('.')

# Build source URL
source_url = "https://www.haproxy.org/download/#{version_major}.#{version_minor}/src/haproxy-#{version}.tar.gz"

# Fetch source tarball 
remote_file 'HAProxy source tarball' do
    source source_url
    path   "/tmp/haproxy-#{version}.tar.gz"
end
