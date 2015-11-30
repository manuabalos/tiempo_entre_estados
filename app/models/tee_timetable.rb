class TeeTimetable < ActiveRecord::Base
  unloadable

  has_many :journals, :class_name => 'TeeTimetableJournal', :dependent => :destroy
  has_and_belongs_to_many :roles
  accepts_nested_attributes_for :journals

  validate :avoid_overlap
  validate :check_timetable_default
  validate :check_dates

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

  # Tiempo trabajado en una semana completa
  def week_total_time
  	journals.inject(0.0){|sum,j| sum + j.day_total_time}
  end

  # Calcula el tiempo trabajado entre dos fechas para este calendario
  def get_time(stime, etime)
  	time = 0

  	if etime.to_date == stime.to_date
  	  time += journal(stime).day_time(stime, etime)
  	else
  	  second_day = (stime + 1.day).to_date
  	  penultimate_day = (etime - 1.day).to_date

      # Calculamos el tiempo las semanas completas que hay en el intervalo
  	  weeks = ([(penultimate_day - second_day).to_i, 0].max / 7).floor
  	  time += weeks * week_total_time

      # Para el resto de días, calculamos por cada día
  	  (stime.to_date..(etime - (weeks * 7).days).to_date).each do |date|
  	    case date
	  	  when stime
	  		time += journal(date).day_time(stime)
	  	  when (etime - weeks.days)
	  		time += journal(date).day_time(nil, etime)
	  	  else
	  		time += journal(date).day_time
	  	end
	  end
	end

	time
  end

  # Devuelve el tiempo total para el intervalo indicado
  def self.get_total_time(project_id, role_id, stime, etime)
    time = 0

    while stime < etime
      timetable = TeeTimetable.joins(:roles).where("project_id = ? AND roles.id = ? AND start_date <= ? AND end_date > ?", project_id, role_id, etime, stime).order(:stime => :desc).first
      
      if timetable.present? and timetable.start_date <= stime
        interval_etime = [timetable.end_date, etime].min
      else
        if timetable.present?
          interval_etime = timetable.start_date
        else
          interval_etime = etime
        end

        timetable = TeeTimetable.joins(:roles).where("project_id = ? AND roles.id = ? AND start_date is NULL AND end_date is NULL", project_id, role_id).first
      end

      if timetable.present?
        time += timetable.get_time(stime, interval_etime)
      end

      stime = interval_etime
    end

    time
  end

  def journal(date)
	journals.where("week_day = ?", date.wday).first
  end

  private
    # Valida que no existen solapamientos
    def avoid_overlap
      errors.add :base, l(:"error.timetable_overlap") if TeeTimetable.joins(:roles).where('tee_timetables.id != ? AND roles.id in (?) AND project_id = ? AND (end_date >= ? AND start_date <= ?)', self.id || '', self.roles.map(&:id), self.project_id, self.start_date, self.end_date).present?  
    end
    
    # Valida que si no es un horario por defecto, start_date y end_date tenga una fecha
    def check_timetable_default 
      errors.add :base, l(:"error.check_timetable_default") if self.default == false && self.start_date == nil && self.end_date == nil
    end

    # Valida que la fecha de inicio no es mayor que la de fin
    def check_dates
      errors.add :base, l(:"error.date_error") if (self.start_date != nil && self.end_date != nil) && (self.start_date > self.end_date)
    end
end