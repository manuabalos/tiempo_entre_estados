class TeeTimetablesController < ApplicationController
  unloadable

  menu_item :config_time_statuses
  before_filter :find_project_by_project_id, :authorize
  
  def index
    @roles = Role.uniq.map{|role| [role.name, role.id]}
    @weeks = ["monday","tuesday","wednesday","thrusday","friday","saturday","sunday"]

    @timetable = TeeTimetable.new
    @journals = []
    7.times do |i|
    	@journals[i] = TeeTimetableJournal.new(:id => i)
    end
  end

   def create
  	#binding.pry
  	tt = TeeTimetable.create(params["tee_timetable"])

	  tt_journals = []

  	if params["journals_attributes"]
      timetables = tt.journals.build
      timetable.save

  		# params["journals_attributes"].each do |ttj|
  		# 	tt_journals << TeeTimetableJournal.create(ttj)
  		# end
  	end

    #tt_journals << TeeTimetableJournal.create(params["tee_timetable_journals"])
  	#tt.journals = tt_journals
    tt.roles = Role.where("id in (?)", params["roles"])
    #binding.pry
  	redirect_to tee_home_path(:project_id => @project.id)
  end
end