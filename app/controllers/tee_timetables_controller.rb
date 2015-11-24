class TeeTimetablesController < ApplicationController
  unloadable

  menu_item :config_time_statuses
  before_filter :find_project_by_project_id, :authorize
  before_filter :set_timetable, only: [:edit, :update, :destroy]
  before_filter :set_roles, only: [:index, :edit]
  before_filter :set_weeks, only: [:index, :edit]
  
  def index
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
    @journals = @timetable.journals
    @rolestimetable = []
    @timetable.roles.collect{|role| @rolestimetable << role[:id]}
  end

  def update 
    roles = Role.where(:id => params[:roles])
    @timetable.roles.destroy_all
    @timetable.roles << roles
   
    if @timetable.update_attributes(params[:tee_timetable]) 
      redirect_to tee_home_path(:project_id => @project.id)
    else
      render 'edit'
    end
  end

  def destroy
    @timetable.journals.destroy_all
    @timetable.destroy
  
    redirect_to tee_home_path(:project_id => @project.id)
  end

  def set_timetable
    @timetable = TeeTimetable.find(params[:id]) 
  end

  def set_roles
    @roles = Role.uniq.map{|role| [role.name, role.id]}
  end

  def set_weeks
    @weeks = [{:id => 1, :name =>"monday"},{:id => 2, :name =>"tuesday"},{:id => 3, :name =>"wednesday"},{:id => 4, :name =>"friday"},{:id => 5, :name =>"saturday"},{:id => 0, :name =>"sunday"}]
  end
end