#
# Cookbook:: cas_haproxy
# Recipe:: configure
# Description:: Configure HAProxy
#

template "HAProxy defaults file" do
    source   'haproxy.erb'
    path     '/etc/default/haproxy'
    owner    'root'
    group    'root'
    mode     0644
    backup   false
    action   :create
end

template "HAProxy service configuration" do
    source   'haproxy.service.erb'
    path     '/lib/systemd/system/haproxy.service'
    owner    'root'
    group    'root'
    mode     0644
    backup   false
    action   :create
end

template "Default HAProxy configuration file" do
    source   'haproxy.cfg.erb'
    path     '/etc/haproxy/haproxy.cfg'
    owner    'root'
    group    'root'
    mode     0644
    backup   false
    action   :create
end

directory '/etc/haproxy/sites' do
    owner  'root'
    group  'root'
    mode   '0755'
    action :create
end

node['cas_haproxy']['sites'].each do |site|
    template "Configuration for #{site['id']}" do
        source   'site.cfg.erb'
        path     "/etc/haproxy/sites/#{site['id']}.cfg"
        owner    'root'
        group    'root'
        mode     0644
        backup   false
        action   :create

        variables(site)
    end
end

# Notified handlers

service 'haproxy'

execute 'sys_reload' do
    command 'systemctl daemon-reload'
    action :nothing
end
