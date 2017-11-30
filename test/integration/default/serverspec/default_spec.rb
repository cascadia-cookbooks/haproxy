require 'spec_helper'

describe 'cas_haproxy::default' do
    describe package('haproxy') do
        it { should be_installed }
    end
end
