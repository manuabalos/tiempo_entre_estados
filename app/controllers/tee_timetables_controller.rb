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
  	tt = TeeTimetable.create(params["tee_timetable"])

  	if params["journals_attributes"]
      timetables = tt.journals.build
      timetable.save
  	end

    tt.roles = Role.where("id in (?)", params["roles"])

  	redirect_to tee_home_path(:project_id => @project.id)
  end

  def edit
    @roles = Role.uniq.map{|role| [role.name, role.id]}
    @weeks = ["monday","tuesday","wednesday","thrusday","friday","saturday","sunday"]

    @timetable = TeeTimetable.find(params[:id])
    @journals = @timetable.journals
    @rolestimetable = []
    @timetable.roles.collect{|role| @rolestimetable << role[:id]}
  end

  def update
    @timetable = TeeTimetable.find(params[:id])  
    @roles = Role.where(:id => params[:roles])
    @timetable.roles.destroy_all
    @timetable.roles << @roles
   
    if @timetable.update_attributes(params[:tee_timetable]) 
      redirect_to tee_home_path(:project_id => @project.id)
    else
      render 'edit'
    end
  end

  def destroy
    binding.pry
    timetable = TeeTimetable.find(params[:id])
    timetable.destroy
    binding.pry
    tee_home_path(:project_id => @project.id)
  end
end