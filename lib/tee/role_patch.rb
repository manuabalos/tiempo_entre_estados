require_dependency 'role'
require 'dispatcher' unless Rails::VERSION::MAJOR >= 3

module TEE
  module RolePatch
    def self.included(base) # :nodoc:
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)

      # Same as typing in the class
      base.class_eval do
        unloadable # Send unloadable so it will be reloaded in development

        has_many :tee_prss
        has_many :projects, :through => :tee_prss
        has_many :statuses, :through => :tee_prss, :class_name => 'IssueStatus', :foreign_key => :status_id
        has_and_belongs_to_many :tee_timetables
      end
    end

    module ClassMethods
      
    end

    module InstanceMethods
      def roles_statuses(project_id)
        result = {:start => [], :pause => [], :close => []}
        tee_prss.where('project_id = ?', project_id).each do |prs|
          result[prs.status_type.to_sym] << {:id => prs.statuses.id, :name => prs.statuses.name}
        end

        return result
      end
    end
  end
end
if Rails::VERSION::MAJOR >= 3
  ActionDispatch::Callbacks.to_prepare do
    # use require_dependency if you plan to utilize development mode
    Role.send(:include, TEE::RolePatch)
  end
else
  Dispatcher.to_prepare do
    Role.send(:include, TEE::RolePatch)
  end
end