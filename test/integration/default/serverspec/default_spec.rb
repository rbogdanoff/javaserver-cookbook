require 'spec_helper'

describe 'javaserver::default' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html

  describe 'java' do
    describe 'is installed' do
  	  describe command('java -version') do
        its(:exit_status) { should eq 0 }
      end
    end
    describe 'is version 7' do
      describe command('java -version') do
        its(:stderr) { should match /java version "1\.7\.0\_79/}
      end
    end
  end

  describe 'tomcat' do
  	describe 'is installed' do
  	  # just check  for expected directory
  	  describe file('/opt/tomcat_javaserver') do
        it { should be_directory }
      end
    end
    describe 'is enabled' do
      describe service('tomcat_javaserver') do
        it { should be_enabled }
      end
    end
    describe 'is running' do
      describe service('tomcat_javaserver') do
        it { should be_running }
      end
    end
    describe 'is listening on port 8080' do
      describe port(8080) do
        it { should be_listening }
      end
    end
  end

  describe 'nginx' do
  	describe 'is installed' do
  	  # just check  for expected directory
      describe service('nginx') do
        it { should be_enabled }
      end
    end
    describe 'is enabled' do
      describe service('nginx') do
        it { should be_enabled }
      end
    end
    describe 'is running' do
      describe service('nginx') do
        it { should be_running }
      end
    end
    describe 'is listening on port 80' do
      describe port(80) do
        it { should be_listening }
      end
    end
  end

  describe 'self-signed cert' do
  	describe x509_certificate('/etc/ssl/private/javaserver.cert') do
      it { should be_certificate }
      it { should be_valid }
    end
    describe x509_private_key('/etc/ssl/private/javaserver.key') do
      it { should be_valid }
    end
    describe x509_private_key('/etc/ssl/private/javaserver.key') do
      it { should have_matching_certificate('/etc/ssl/private/javaserver.cert') }
    end
  	describe 'is in the java keystore' do
  	  describe command('keytool -list -v -storepass changeit -noprompt -keystore /usr/lib/jvm/java-7-oracle-amd64/jre/lib/security/cacerts -alias javaserver') do
        its(:exit_status) { should eq 0 }
      end
    end
  end
end
