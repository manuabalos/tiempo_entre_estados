class TeeTimetable < ActiveRecord::Base
  unloadable

  has_many :journals, :class_name => 'TeeTimetableJournal'
  scope :journal, ->(date) {includes(:journals).were("journals.week_day = ?", date.wday)}
  has_and_belongs_to_many :roles

  # Tiempo trabajado en una semana completa
  def week_total_time
  	journals.inject(0.0){|sum,j| sum + j.day_total_time}
  end

  # Calcula el tiempo trabajado entre dos fechas para este calendario
  def get_time(stime, etime)
  	time = 0

  	if Date.parse(etime.to_s) == Date.parse(stime.to_s)
  		time += journal(stime).day_time(stime, etime)
  	else
  		second_day = Date.parse((stime + 1.day).to_s)
  		penultimate_day = Date.parse((etime - 1.day).to_s)

  		weeks = ([(penultimate_day - second_day).to_i, 0].max / 7).floor

  		(stime..(etime - weeks.days)).each do |date|
  			case date
	  			when stime
	  				time += journal(date).day_time(date)
	  			when (etime - weeks.days)
	  				time += journal(date).day_time(nil, date)
	  			else
	  				time += journal(date).day_time
	  		end
	  	end
	  end

	  time
	end

	# Devuelve el calendario correspondiente al intervalo indicado
	def self.get_calendar(stime, etime)
		#where("start_date <= ? AND end_date >= ?", etime, stime)
	end
end
