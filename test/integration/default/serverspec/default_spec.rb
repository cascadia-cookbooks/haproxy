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
        its(:content) { should include '' }
    end

    describe file('/lib/systemd/system/haproxy.service') do
        it { should exist }
        it { should be_owned_by 'root' }
        it { should be_grouped_into 'root' }
        it { should be_mode 644 }
        its(:content) { should include '' }
    end

    describe file('/etc/haproxy/sites/blog.cfg') do
        it { should exist }
        it { should be_owned_by 'root' }
        it { should be_grouped_into 'root' }
        it { should be_mode 644 }
        its(:content) { should include '' }
    end

    describe file('/etc/haproxy/sites/wiki.cfg') do
        it { should exist }
        it { should be_owned_by 'root' }
        it { should be_grouped_into 'root' }
        it { should be_mode 644 }
        its(:content) { should include '' }
    end
end
