class TeeTimetable < ActiveRecord::Base
  unloadable

  has_many :journals, :class_name => 'TeeTimetableJournal'
  has_and_belongs_to_many :roles
  accepts_nested_attributes_for :journals

  before_save :one_hour_less

  private
  	def one_hour_less
  		# self.journals.each do |journal|
  		# 	journal.start_time = journal.start_time - 1.hour
  		# 	journal.end_time = journal.end_time - 1.hour
  		# end
  	end
end