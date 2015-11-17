require_dependency 'project'
require 'dispatcher' unless Rails::VERSION::MAJOR >= 3

module TEE
  module ProjectPatch
    def self.included(base) # :nodoc:
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)

      # Same as typing in the class
      base.class_eval do
        unloadable # Send unloadable so it will be reloaded in development

        has_many :prss
        has_many :roles, :through => :prss
        has_many :status, :through => :prss, :class_name => 'IssueStatus', :foreign_key => :status_id
      end
    end

    module ClassMethods
      
    end

    module InstanceMethods
      
    end
  end
end
if Rails::VERSION::MAJOR >= 3
  ActionDispatch::Callbacks.to_prepare do
    # use require_dependency if you plan to utilize development mode
    Project.send(:include, TEE::ProjectPatch)
  end
else
  Dispatcher.to_prepare do
    Project.send(:include, TEE::ProjectPatch)
  end
end