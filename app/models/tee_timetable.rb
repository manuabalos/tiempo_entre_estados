class TeeTimetable < ActiveRecord::Base
  unloadable

  has_many :journals, :class_name => 'TeeTimetableJournal'
  has_and_belongs_to_many :roles

end
