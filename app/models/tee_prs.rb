class TeePrs < ActiveRecord::Base
  unloadable
  belongs_to :project 
  belongs_to :role
  belongs_to :statuses, :class_name => 'IssueStatus', :foreign_key => :status_id
end
