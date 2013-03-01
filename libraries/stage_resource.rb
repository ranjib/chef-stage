require 'chef/resource'

class Chef
  class Resource
    class Stage < Chef::Resource

      def initialize(name, run_context=nil)
        super(name, run_context)
        @resource_name = :stage
        @name = name
        @save = true
        @json_attributes = {}
        @arguments = {}
        @action = "run"
        @allowed_actions.push(:run)
      end

      def name(arg=nil)
        set_or_return(:name, arg, :kind_of => String)
      end

      def save(arg=nil)
        set_or_return(:save, arg, :kind_of => [TrueClass, FalseClass])
      end

      def run_list(arg=nil)
        set_or_return(:run_list, arg, :kind_of => String)
      end

      def json_attributes(arg=nil)
        set_or_return(:json_attributes, arg, :kind_of => Hash)
      end

      def arguments(arg=nil)
        set_or_return(:arguments, arg, :kind_of => Hash)
      end
      
      def resources(&block)
        if block_given?
          @block = block
        else
          @block = nil
        end
      end
      
    end
  end
end
