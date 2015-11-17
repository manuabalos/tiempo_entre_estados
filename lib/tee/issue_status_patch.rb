require_dependency 'issue_status'
require 'dispatcher' unless Rails::VERSION::MAJOR >= 3

module TEE
  module IssueStatusPatch
    def self.included(base) # :nodoc:
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)

      # Same as typing in the class
      base.class_eval do
        unloadable # Send unloadable so it will be reloaded in development

        has_many :prss
        has_many :projects, :through => :prss
        has_many :roles, :through => :prss
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
    IssueStatus.send(:include, TEE::IssueStatusPatch)
  end
else
  Dispatcher.to_prepare do
    IssueStatus.send(:include, TEE::IssueStatusPatch)
  end
end