class TeeHolidaysController < ApplicationController
  unloadable
  menu_item :config_time_statuses
  before_filter :find_project_by_project_id, :authorize
  before_filter :set_holiday, only: [:edit, :update, :destroy]
  before_filter :set_roles, only: [:index, :edit]

  def index
  	@holiday = TeeHoliday.new
  end

  def create
  	@holiday = TeeHoliday.new(params["tee_holiday"])

  	@holiday.roles = Role.where("id in (?)", params["roles"])

  	if @holiday.save
      flash[:notice] = l(:"holiday.holiday_notice_create")
  	  redirect_to tee_home_path(:project_id => @project)
    else
      flash[:error] = @holiday.get_error_message
      redirect_to action: 'index', :project_id => @project
    end
  end

  def edit
    @rolestimetable = []
    @holiday.roles.collect{|role| @rolestimetable << role[:id]}
  end

 def update 
    roles = Role.where(:id => params[:roles])
    binding.pry
    @holiday.roles.destroy_all
    @holiday.roles << roles
    binding.pry
    if @holiday.update_attributes(params[:tee_holiday]) 
      flash[:notice] = l(:"holiday.holiday_notice_edit")
      redirect_to tee_home_path(:project_id => @project.id)
    else
      flash[:error] = @holiday.get_error_message
      redirect_to action: 'edit', :project_id => @project.id
    end
  end

  def destroy
    if @holiday.destroy
      flash[:notice] = l(:"holiday.holiday_notice_destroy")
    else
      flash[:error] = l(:"error.holiday_destroy")
    end

    redirect_to tee_home_path(:project_id => @project.id)
  end

  def set_holiday
    @holiday = TeeHoliday.find(params[:id]) 
  end 

  def set_roles
    @roles = Role.uniq.map{|role| [role.name, role.id]}
  end

end