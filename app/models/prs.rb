class Prs < ActiveRecord::Base
  unloadable
  belongs_to :project 
  belongs_to :role
  belongs_to :status
end
