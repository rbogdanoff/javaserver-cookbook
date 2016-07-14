# Recipe:: rootapp
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

# this is nothing more then an index.html file so, for testing, there will
# be a 'welcome' web page displayed by tomcat

directory 'rootapp' do
  owner node['javaserver']['tomcat']['user']
  group node['javaserver']['tomcat']['group']
  mode '0755'
  path "#{node['javaserver']['tomcat']['installpath']}/webapps/ROOT"
  action :create
end

cookbook_file 'welcome' do
  owner node['javaserver']['tomcat']['user']
  group node['javaserver']['tomcat']['group']
  mode '0755'
  path "#{node['javaserver']['tomcat']['installpath']}/webapps/ROOT/index.html"
  source 'index.html'
  action :create
end
