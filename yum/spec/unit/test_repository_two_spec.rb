require 'spec_helper'

describe 'yum_test::test_repository_two' do

  let(:test_repository_two_run) do
    ChefSpec::Runner.new(
      :step_into => 'yum_repository'
      ).converge(described_recipe)
  end

  let(:test_repository_two_template) do
    test_repository_two_run.template('/etc/yum.repos.d/unit-test-2.repo')
  end

  let(:test_repository_two_content) do
    '# This file was generated by Chef
# Do NOT modify this file by hand.

[unit-test-2]
name=test all the things!
baseurl=http://example.com/wat
cost=10
enabled=1
enablegroups=1
exclude=package1 package2 package3
failovermethod=priority
fastestmirror_enabled=true
gpgcheck=1
gpgkey=http://example.com/RPM-GPG-KEY-FOOBAR-1
http_caching=all
include=/some/other.repo
includepkgs=package4 package5
keepalive=1
metadata_expire=never
mirrorlist=http://hellothereiammirrorliststring.biz
mirror_expire=300
mirrorlist_expire=86400
priority=10
proxy=http://hellothereiamproxystring.biz
proxy_username=kermit
proxy_password=dafrog
retries=10
skip_if_unavailable=1
sslcacert=/path/to/directory
sslclientcert=/path/to/client/cert
sslclientkey=/path/to/client/key
sslverify=1
timeout=10
'
  end

  context 'creating a yum_repository with full parameters' do
    it 'creates yum_repository[test2]' do
      expect(test_repository_two_run).to create_yum_repository('test2')
    end

    it 'steps into yum_repository and creates template[/etc/yum.repos.d/unit-test-2.repo]' do
      expect(test_repository_two_run).to create_template('/etc/yum.repos.d/unit-test-2.repo')
    end

    it 'steps into yum_repository and renders file[/etc/yum.repos.d/unit-test-2.repo]' do
      expect(test_repository_two_run).to render_file('/etc/yum.repos.d/unit-test-2.repo').with_content(test_repository_two_content)
    end

    it 'steps into yum_repository and runs execute[yum-makecache-unit-test-2]' do
      expect(test_repository_two_run).to_not run_execute('yum-makecache-unit-test-2')
    end

    it 'steps into yum_repository and runs ruby_block[yum-cache-reload-unit-test-2]' do
      expect(test_repository_two_run).to_not run_ruby_block('yum-cache-reload-unit-test-2')
    end

    it 'sends a :run to execute[yum-makecache-unit-test-2]' do
      expect(test_repository_two_template).to notify('execute[yum-makecache-unit-test-2]')
    end

    it 'sends a :create to ruby_block[yum-cache-reload-unit-test-2]' do
      expect(test_repository_two_template).to notify('ruby_block[yum-cache-reload-unit-test-2]')
    end
  end

end
