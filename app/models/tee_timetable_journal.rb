class TeeTimetableJournal < ActiveRecord::Base
  unloadable
  scope :week_day, ->(wday) {were("week_day = ?", wday)}

  belongs_to :journals

end
