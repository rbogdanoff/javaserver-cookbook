#
# Cookbook Name:: javaserver
# Attributes:: default
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

default['javaserver']['java']['version']  = '7'
default['javaserver']['java']['tarball_url']  = 'http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz'
default['javaserver']['java']['checksum'] = 'c4deb058f674ab732b36a101147add089cf7f134'

default['javaserver']['tomcat']['user']  = 'javaserver'
default['javaserver']['tomcat']['group'] = 'javaserver'
default['javaserver']['tomcat']['version'] = '7.0.67'
# TODO: build download_url from other attrs so all you need to do is set version
# and full url will get assembled for it
default['javaserver']['tomcat']['download_url'] = 'http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.67/bin/apache-tomcat-7.0.67.tar.gz'
default['javaserver']['tomcat']['servicename'] = node['javaserver']['tomcat']['user']
default['javaserver']['tomcat']['installpath'] = "/opt/tomcat_#{node['javaserver']['tomcat']['servicename']}"

default['javaserver']['nginx']['sitename'] = node['javaserver']['tomcat']['servicename']
