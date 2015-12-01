require_dependency 'issue'
require 'dispatcher' unless Rails::VERSION::MAJOR >= 3

module TEE
  module IssuePatch
    def self.included(base) # :nodoc:
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)

      # Same as typing in the class
      base.class_eval do
        unloadable # Send unloadable so it will be reloaded in development

      end
    end

    module ClassMethods
      
    end

    module InstanceMethods
      def get_intervals
        result = []
        jorunals = JournalDetail.joins(:journal).where('journals.journalized_id = ? AND prop_key = ?', 1, 'status_id').select("journal_details.old_value, journal_details.value, journals.created_on AS end")
        start = self.created_on

        journals.each do |journal|
          result << {:status_id => journal.old_value, :start => start, :end => journal.end}
          start = journal.end
        end
        result << {:status_id => result.last.value, :start => start, :end => DateTime.current}
      end
    end
  end
end
if Rails::VERSION::MAJOR >= 3
  ActionDispatch::Callbacks.to_prepare do
    # use require_dependency if you plan to utilize development mode
    Issue.send(:include, TEE::IssuePatch)
  end
else
  Dispatcher.to_prepare do
    Issue.send(:include, TEE::IssuePatch)
  end
end