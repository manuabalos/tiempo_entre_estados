class TeeHoliday < ActiveRecord::Base
  unloadable

  has_and_belongs_to_many :roles

  # Genera mensaje de error
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
  
end