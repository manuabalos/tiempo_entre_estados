class TeeTimetable < ActiveRecord::Base
  unloadable

  has_many :journals, :class_name => 'TeeTimetableJournal', :dependent => :destroy
  has_and_belongs_to_many :roles
  accepts_nested_attributes_for :journals

end