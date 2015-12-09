class TeeHolidaysController < ApplicationController
  unloadable
  menu_item :config_time_statuses
  before_filter :find_project_by_project_id, :authorize

  def index
  	@holiday = TeeHoliday.new
  	@roles = Role.uniq.map{|role| [role.name, role.id]}
  end

  def create
  	@holiday = TeeHoliday.new(params["tee_holiday"])

  	@holiday.roles = Role.where("id in (?)", params["roles"])

  	if @holiday.save
      flash[:notice] = l(:"holiday.holiday_notice_create")
  	  redirect_to tee_home_path(:project_id => @project.id)
    else
      flash[:error] = @holiday.get_error_message
      redirect_to action: 'index', :project_id => @project.id
    end
  end

end