class TeeTimetablesController < ApplicationController
  unloadable
  include TeeTimetablesHelper

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
  	@timetable = TeeTimetable.new(params["tee_timetable"])

  	if params["journals_attributes"]
      @timetable.journals.build
  	end

    @timetable.roles = Role.where("id in (?)", params["roles"])

    if @timetable.save
      flash[:notice] = l(:"timetable.timetable_notice_create")
  	  redirect_to project_tee_home_path(:project_id => @project)
    else
      flash[:error] = @timetable.get_error_message
      redirect_to action: 'index', :project_id => @project
    end
  end

  def edit
    @journals = @timetable.journals

    @rolestimetable = []
    @timetable.roles.collect{|role| @rolestimetable << role[:id]}
  end

  def update 
    old_roles = @timetable.roles.map{|r| r.id}
    roles = Role.where(:id => params[:roles])
    @timetable.roles = roles

    if @timetable.update_attributes(params[:tee_timetable]) 
      flash[:notice] = l(:"timetable.timetable_notice_edit")
      redirect_to project_tee_home_path(:project_id => @project)
    else
      @timetable.roles = Role.find(old_roles)
      flash[:error] = @timetable.get_error_message
      redirect_to action: 'edit', :project_id => @project
    end
  end

  def destroy
    if @timetable.destroy
      flash[:notice] = l(:"timetable.timetable_notice_destroy")
    else
      flash[:error] = l(:"error.timetable_destroy")
    end

    redirect_to project_tee_home_path(:project_id => @project)
  end

  def set_timetable
    @timetable = TeeTimetable.find(params[:id]) 
  end 

  def set_roles
    @roles = Role.uniq.map{|role| [role.name, role.id]}
  end
end