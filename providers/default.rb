#
# Cookbook Name:: stage
# Provider:: default
#
# Author:: Ranjib Dey
#
# Copyright 2013, Ranjib Dey
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
#

def whyrun_supported?
  true
end

action :run do
  stage = new_resource.name
  Chef::Log.info("Executing stage: #{new_resource.name} with runlist: '#{new_resource.run_list}'")
  staged_chef_client = Chef::StagedChefClient.new(stage, new_resource.json_attributes, new_resource.arguments)
  staged_chef_client.run_chef_stage(new_resource.run_list)
  unless staged_chef_client.run_status.updated_resources.empty?
    new_resource.updated_by_last_action(true)
  end

  if new_resource.save
    Chef::Log.info("Executing stage: #{new_resource.name} saving node")
    node.consume_attributes(staged_chef_client.cleanse_attrs)
  end
end

