class TeeTimetableJournal < ActiveRecord::Base
  unloadable
  #scope :week_day, ->(wday) {were("week_day = ?", wday)}

  belongs_to :journals

  # Tiempo trabajado en el día completo
  def day_total_time
  	end_time - start_time
  end

  # Tiempo trabajado desde la hora indicada en stime hasta la hora indicada en etime. Si alguno es nil, se considera el inicio/fin de la jornada
  def day_time(stime = nil, etime = nil)
    # Horas de inicio y fin de jornada
    jstime = normalize_time(start_time)
    jetime = normalize_time(end_time)

    # Si stime es nulo, toma el valor del inicio de la jornada
    if stime.present?
      stime = normalize_time(stime)
    else
      stime = jstime
    end

    # Si etime es nulo, toma el valor del fin de la jornada
    if etime.present?
      etime = normalize_time(etime) 
    else
      etime = jetime
    end

    [([etime, jetime].min.to_i - [stime, jstime].max.to_i), 0].max
  end

  private
  # Dado que se está trabajando con horas y no días, establecemos los datetimes al día de hoy
  def normalize_time(time)
  	time.change(:day => Date.today.day, :month => Date.today.month, :year => Date.today.year)
  end
end
