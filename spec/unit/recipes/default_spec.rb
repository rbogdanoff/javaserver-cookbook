#
# Cookbook Name:: javaserver
# Spec:: default
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


require 'spec_helper'

describe 'javaserver::default'  do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04')
        .converge(described_recipe)
    end

    before do
       stub_command("which nginx").and_return('1.2.3')
    end

    it 'includes the java recipe' do
      expect(chef_run).to include_recipe('java::default')
    end

    it 'includes the nginx recipe' do
       expect(chef_run).to include_recipe('nginx::default')
    end

    it 'installs tomcat' do
       expect(chef_run).to install_tomcat_install(chef_run.node['javaserver']['tomcat']['servicename'])
    end

    it 'sets up the tomcat service' do
       expect(chef_run).to enable_tomcat_service(chef_run.node['javaserver']['tomcat']['servicename'])
       expect(chef_run).to start_tomcat_service(chef_run.node['javaserver']['tomcat']['servicename'])
    end

    it 'configures nginx default-site' do
        expect(chef_run).to create_template('default-site').with(
          mode:   '0700'
        )
    end

end
