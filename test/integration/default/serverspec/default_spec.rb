require 'spec_helper'

describe 'cas_haproxy::install' do
    describe package('haproxy') do
        it { should be_installed }
    end

    describe command('haproxy -v') do
        its(:stdout) { should contain('1.8.1').after('HA-Proxy version') }
    end
end

describe 'cas_haproxy::config' do
    describe file('/etc/haproxy/haproxy.cfg') do
        it { should exist }
        it { should be_owned_by 'root' }
        it { should be_grouped_into 'root' }
        it { should be_mode 644 }
    end

    describe file('/etc/default/haproxy') do
        it { should exist }
        it { should be_owned_by 'root' }
        it { should be_grouped_into 'root' }
        it { should be_mode 644 }
        its(:content) { should include '-f /etc/haproxy/sites/blog.cfg' }
        its(:content) { should include '-f /etc/haproxy/sites/wiki.cfg' }
    end

    describe file('/lib/systemd/system/haproxy.service') do
        it { should exist }
        it { should be_owned_by 'root' }
        it { should be_grouped_into 'root' }
        it { should be_mode 644 }
        its(:content) { should include '' }
    end
end

describe 'cas_haproxy::sites' do
    describe file('/etc/haproxy/sites/blog.cfg') do
        it { should exist }
        it { should be_owned_by 'root' }
        it { should be_grouped_into 'root' }
        it { should be_mode 644 }
        its(:content) { should include 'frontend blog' }
        its(:content) { should include 'bind *:6061' }
        its(:content) { should include '# arbitrary frontend config item'}
        its(:content) { should include 'acl host_blog hdr(host) -i example.com blog.example.com' }
        its(:content) { should include 'use_backend blog_cluster if host_blog' }
        its(:content) { should include 'backend blog_cluster' }
        its(:content) { should include 'balance leastconn' }
        its(:content) { should include 'mode http' }
        its(:content) { should include '# arbitrary backend config item'}
        its(:content) { should include 'server web1 web1.local:80 check' }
        its(:content) { should include 'server web2 web2.local:80 check' }
        its(:content) { should include 'server web3.local web3.local:80 check' }
    end

    describe file('/etc/haproxy/sites/wiki.cfg') do
        it { should exist }
        it { should be_owned_by 'root' }
        it { should be_grouped_into 'root' }
        it { should be_mode 644 }
        its(:content) { should include 'frontend wiki' }
        its(:content) { should include 'bind *:80' }
        its(:content) { should include 'acl host_wiki hdr(host) -i wiki.example.com' }
        its(:content) { should include 'use_backend wiki_cluster if host_wiki' }
        its(:content) { should include 'backend wiki_cluster' }
        its(:content) { should include 'balance roundrobin' }
        its(:content) { should include 'mode tcp' }
        its(:content) { should include 'stick-table type ip size 20k expire 1h' }
        its(:content) { should include 'stick on src' }
        its(:content) { should include 'server web4.local web4.local check' }
        its(:content) { should include 'server web5.local web5.local check' }
        its(:content) { should include 'server web6.local web6.local:5000 check' }
    end
end

describe 'cas_haproxy::stats' do
    describe file('/etc/haproxy/haproxy.cfg') do
        its(:content) { should include 'stats socket /var/run/haproxy.sock user root group root mode 600 level operator' }
        its(:content) { should include 'stats timeout 10s' }
        its(:content) { should include 'stats maxconn 10' }
        its(:content) { should include 'listen stats' }
        its(:content) { should include 'stats enable' }
        its(:content) { should include 'mode http' }
        its(:content) { should include 'bind :9001' }
        its(:content) { should include 'stats realm HAProxy-Stats' }
        its(:content) { should include 'stats uri /haproxy_stats' }
        its(:content) { should include 'stats auth username:password' }
        its(:content) { should include 'stats hide-version' }
    end
end
