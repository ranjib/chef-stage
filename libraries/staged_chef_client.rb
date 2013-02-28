#
# Cookbook Name:: stage
# Library:: staged_chef_client
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
require 'digest/md5'

class Chef
  class StagedChefClient < Client
    def initialize(stage_name, json_attributes=nil, arguments={})
      super(json_attributes, arguments)
      @stage_name = stage_name
    end

    def run_chef_stage(stage_run_list)
      cache_path = Chef::Config[:file_cache_path]
      begin
        stage_digest = Digest::MD5.hexdigest(@stage_name)   
        Chef::Config[:file_cache_path] = File.join(Chef::Config[:file_cache_path], 
                                               "stage-#{stage_digest}")
        run_ohai
        register unless Chef::Config[:solo]
        load_node
        run_list_items = stage_run_list.split(",").collect do |item|
          Chef::RunList::RunListItem.new(item)
        end
        node.run_list(*run_list_items)
        build_node
        run_context = setup_run_context
        converge(run_context)
      ensure
        Chef::Config[:file_cache_path] = cache_path 
      end
    end

    def cleanse_attrs
      data = node.to_hash
      %w{run_list recipes roles}.each do |k|
        data.delete(k)
      end
      data
    end
    
    def run_completed_successfully
      # do nothing
    end
  end
end
