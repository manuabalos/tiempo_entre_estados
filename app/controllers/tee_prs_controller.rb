class TeePrsController < ApplicationController
  unloadable

  menu_item :config_time_statuses
  before_filter :find_project_by_project_id, :authorize

  def index
  	@statuses = IssueStatus.uniq.map{|status| [status.name, status.id]}

	@role = Role.find(params[:role_id])

	@start = @role.roles_statuses[:start].map{|e| e[:id]}
	@pause = @role.roles_statuses[:pause].map{|e| e[:id]}
	@close = @role.roles_statuses[:close].map{|e| e[:id]}
  end

end