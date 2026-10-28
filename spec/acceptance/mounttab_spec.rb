# frozen_string_literal: true

require 'spec_helper_acceptance'

# Containers can't mount filesystems, so only manage entries in a scratch fstab
describe 'mounttab' do
  before(:all) do
    shell("printf '/dev/sda1 / ext4 defaults 0 1\\n' > /tmp/fstab_test")
  end

  context 'with ensure => present' do
    it_behaves_like 'an idempotent resource' do
      let(:manifest) do
        <<~PUPPET
          mounttab { '/mnt':
            ensure   => present,
            device   => '/dev/myvg/mytest',
            fstype   => 'ext4',
            options  => ['nosuid', 'noatime'],
            dump     => '1',
            pass     => '2',
            target   => '/tmp/fstab_test',
            provider => augeas,
          }
        PUPPET
      end
    end

    describe file('/tmp/fstab_test') do
      its(:content) { is_expected.to match(%r{^/dev/sda1\s+/\s+ext4\s+defaults\s+0\s+1$}) }
      its(:content) { is_expected.to match(%r{^/dev/myvg/mytest\s+/mnt\s+ext4\s+nosuid,noatime\s+1\s+2$}) }
    end
  end

  context 'with ensure => absent' do
    it_behaves_like 'an idempotent resource' do
      let(:manifest) do
        <<~PUPPET
          mounttab { '/mnt':
            ensure   => absent,
            target   => '/tmp/fstab_test',
            provider => augeas,
          }
        PUPPET
      end
    end

    describe file('/tmp/fstab_test') do
      its(:content) { is_expected.not_to match(%r{/mnt}) }
      its(:content) { is_expected.to match(%r{^/dev/sda1\s+/\s+ext4}) }
    end
  end
end
