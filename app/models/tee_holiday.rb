class TeeHoliday < ActiveRecord::Base
  unloadable

  has_and_belongs_to_many :roles

  validate :check_name_blank
  validate :check_name_uniq

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
  
  private

  # Valida que el nombre del calendario de festivos no este en blanco
  def check_name_blank
    errors.add :base, l(:"error.holiday_name_blank") if self.name.blank?
  end

  # Valida que el nombre del calendario de festivos no este repetido
  def check_name_uniq
    if self.id != nil
      errors.add :base, l(:"error.holiday_name_uniq") if TeeHoliday.where("name = ? AND id != ?", self.name, self.id).present?
    else
      errors.add :base, l(:"error.holiday_name_uniq") if TeeHoliday.where(name: self.name).present?
    end
  end

end