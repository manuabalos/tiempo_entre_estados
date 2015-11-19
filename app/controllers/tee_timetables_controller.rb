class TeeTimetablesController < ApplicationController
  unloadable

  menu_item :config_time_statuses
  before_filter :find_project_by_project_id, :authorize
  
  def index
    @users = User.all
  end
end