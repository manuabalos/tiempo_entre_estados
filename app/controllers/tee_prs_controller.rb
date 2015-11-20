class TeePrsController < ApplicationController
  unloadable

  menu_item :config_time_statuses
  before_filter :find_project_by_project_id, :authorize

  def index
  	@statuses = IssueStatus.uniq.map{|status| [status.name, status.id]}

	@role = Role.find(params[:role_id])

	@start = @role.roles_statuses(@project.id)[:start].map{|e| e[:id]}
	@pause = @role.roles_statuses(@project.id)[:pause].map{|e| e[:id]}
	@close = @role.roles_statuses(@project.id)[:close].map{|e| e[:id]}

  end

  def create
  	role = Role.find(params[:role_id])

  	role.tee_prss.where('project_id = ?', @project.id).delete_all

  	type_status = ["start","pause","close"]

  	type_status.each do |type|
	  	params[type.to_sym].each do |status|
	  		new_prs = TeePrs.new
	  		new_prs.project_id = params[:project_id] 
	  		new_prs.role_id = params[:role_id] 
	  		new_prs.status_id = status.to_i
	  		new_prs.status_type = type
	  	 	new_prs.save
	  	end
  	end

  	redirect_to tee_home_path(:project_id => @project.id)
  end

end