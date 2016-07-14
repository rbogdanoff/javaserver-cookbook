#
# Cookbook Name:: javaserver
# Recipe:: default
#
# Copyright 2016 Ron Bogdanoff
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# make sure apt repo is up to date
include_recipe 'apt'

# install oracle jdk
node.set['java']['jdk_version']                            = node['javaserver']['java']['version']
node.set['java']['install_flavor']                         = 'oracle'
node.set['java']['oracle']['accept_oracle_download_terms'] = true
node.set['java']['jdk']['7']['x86_64']['url']              = node['javaserver']['java']['tarball_url']
node.set['java']['jdk']['7']['x86_64']['checksum']         = node['javaserver']['java']['checksum']

include_recipe 'java::default'

# install tomcat
tomcat_install node['javaserver']['tomcat']['servicename'] do
  version node['javaserver']['tomcat']['version']
  tarball_uri node['javaserver']['tomcat']['download_url']
  tomcat_user node['javaserver']['tomcat']['user']
  tomcat_group node['javaserver']['tomcat']['group']
end

tomcat_service node['javaserver']['tomcat']['servicename'] do
  tomcat_user node['javaserver']['tomcat']['user']
  tomcat_group node['javaserver']['tomcat']['group']
  action [:enable, :start]
end

# generate a self-signed cert
# TODO: use attributes to config - right now this is quick and dirty hardcode
execute 'self_signed_cert' do
  command "openssl req -new -newkey rsa:4096 -nodes -days 365 -nodes -x509 -subj '/C=US/ST=CA/L=PA/O=XX/CN=*' \
              -keyout /etc/ssl/private/#{node['javaserver']['nginx']['sitename']}.key \
              -out /etc/ssl/private/#{node['javaserver']['nginx']['sitename']}.cert"
  not_if do
    File.exist?("/etc/ssl/private/#{node['javaserver']['nginx']['sitename']}.key") &&
      File.exist?("/etc/ssl/private/#{node['javaserver']['nginx']['sitename']}.cert")
  end
  notifies :run, 'execute[java_cert]', :immediately
  notifies :restart, 'service[nginx]', :delayed
end

# insert the self-signed cert into the java keystore
# TODO: we need to change keystore password AND access it from some vault instead of hardcode
execute 'java_cert' do
  command "keytool -import -trustcacerts -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit \
             -noprompt -alias javaserver -file /etc/ssl/private/#{node['javaserver']['nginx']['sitename']}.cert"
  action :nothing
end

# install nginx
include_recipe 'nginx::default'

# config the nginx default-site to proxy to tomcat
template 'default-site' do
  source 'default.erb'
  path '/etc/nginx/sites-enabled/default'
  mode '0700'
  notifies :restart, 'service[nginx]', :delayed
end

service 'nginx' do
  action [:enable, :start]
end
