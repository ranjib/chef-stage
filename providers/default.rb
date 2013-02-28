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
  chef_client = Chef::Client.new
  chef_client.run_ohai
  chef_client.register unless Chef::Config[:solo]
  chef_client.load_node
  run_list = new_resource.run_list.split(",").collect do |item|
    Chef::RunList::RunListItem.new(item)
  end
  Chef::Log.info("Executing stage: #{new_resource.name} with runlist: '#{run_list}'")

  chef_client.node.run_list(*run_list)
  chef_client.build_node

  run_context = chef_client.setup_run_context
  chef_client.converge(run_context)

  unless chef_client.run_status.updated_resources.empty?
    new_resource.updated_by_last_action(true)
  end

  if new_resource.save
    Chef::Log.info("Executing stage: #{new_resource.name} saving node")
    data = chef_client.node.to_hash
    %w{run_list recipes roles}.each do |k|
      data.delete(k)
    end
    node.consume_attributes(data)
  end
end

