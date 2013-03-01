require 'chef/provider'

class Chef
  class Provider
    class Stage < Chef::Provider

      def whyrun_supported?
        true
      end

      def load_current_resource
        true
      end

      def action_run 
        stage = @new_resource.name
        Chef::Log.info("Executing stage: #{@new_resource.name} with runlist: '#{@new_resource.run_list}'")
        staged_chef_client = Chef::StagedChefClient.new(stage, @new_resource.json_attributes, @new_resource.arguments)
        staged_chef_client.run_chef_stage(@new_resource.run_list)
        unless staged_chef_client.run_status.updated_resources.empty?
          @new_resource.updated_by_last_action(true)
        end

        if @new_resource.save
          Chef::Log.info("Executing stage: #{@new_resource.name} saving node")
          node.consume_attributes(staged_chef_client.cleanse_attrs)
        end
      end
    end
  end
end

