require 'spec_helper'

describe 'cas_haproxy::default' do
    describe package('haproxy') do
        it { should be_installed }
    end

    describe file('/etc/haproxy/haproxy.cfg') do
        it { should exist }
        it { should be_owned_by 'root' }
        it { should be_grouped_into 'root' }
        it { should be_mode 644 }
        its(:content) { should include '' }
    end

    describe file('/etc/default/haproxy') do
        it { should exist }
        it { should be_owned_by 'root' }
        it { should be_grouped_into 'root' }
        it { should be_mode 644 }
        its(:content) { should include 'EXTRAOPTS="$EXTRAOPTS -f /etc/haproxy/sites/blog.cfg"' }
        its(:content) { should include 'EXTRAOPTS="$EXTRAOPTS -f /etc/haproxy/sites/wiki.cfg"' }
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
        its(:content) { should include 'acl host_blog hdr(host) -i example.com blog.example.com' }
        its(:content) { should include 'use_backend blog_cluster if host_blog' }
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
    end
end