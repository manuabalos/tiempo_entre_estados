class TeeTimetable < ActiveRecord::Base
  unloadable

  has_many :journals, :class_name => 'TeeTimetableJournal', :dependent => :destroy
  has_and_belongs_to_many :roles
  accepts_nested_attributes_for :journals

  validate :avoid_overlap
  validate :check_dates

  def get_error_message
    error_msg = ""
    
    self.errors.full_messages.each do |msg|
      if error_msg != ""
        error_msg << "<br>"
      end
      error_msg << msg
    end

    error_msg
  end

  private
    def avoid_overlap
      errors.add :base, l(:text_calendar_error_overlap) if TeeTimetable.joins(:roles).where('tee_timetables.id != ? AND roles.id in (?) AND project_id = ? AND (end_date >= ? AND start_date <= ?)', self.id || '', self.roles.map(&:id), self.project_id, self.start_date, self.end_date).present?  
    end

    def check_dates
      errors.add :base, l(:text_date_error) if self.start_date > self.end_date
    end
end