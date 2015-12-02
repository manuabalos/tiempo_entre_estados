require_dependency 'issues_controller'
require 'dispatcher' unless Rails::VERSION::MAJOR >= 3

module TEE
	module IssuesControllerPatch
	  def self.included(base) # :nodoc:
	    base.extend(ClassMethods)
	    base.send(:include, InstanceMethods)
	    base.class_eval do
	      unloadable  # Send unloadable so it will be reloaded in development
	      alias_method_chain :show, :total_time
	    end
	  end

	  module InstanceMethods
	  	# Recoge los intervalos de tiempo por lo que ha pasado una petición y calcula el tiempo total en horas.
	   def show_with_total_time
	    	@total_time = 0
			intervals = @issue.get_intervals
			start_statuses = Role.all.map{|r| {r.id => r.roles_statuses(@issue.project_id)[:start]}}.inject(:merge)

			start_statuses.each do |role, statuses|
			 intervals.each do |interval|
			   if statuses.map{|s| s[:id]}.include?(interval[:status_id])
			     @total_time += TeeTimetable.get_total_time(@issue.project_id, role, interval[:start], interval[:end])
			   end
			 end
			end
			@total_time = ((@total_time/60)/60).round(1)
	      show_without_total_time
	   end
	  end

	  module ClassMethods
	  end
	end
end
if Rails::VERSION::MAJOR >= 3
  ActionDispatch::Callbacks.to_prepare do
    IssuesController.send(:include, TEE::IssuesControllerPatch)
  end
else
  Dispatcher.to_prepare do
    IssuesController.send(:include, TEE::IssuesControllerPatch)
  end
end