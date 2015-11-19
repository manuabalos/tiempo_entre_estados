class TeeController < ApplicationController
  unloadable

  menu_item :config_time_statuses
  before_filter :find_project_by_project_id, :authorize

  def index
    @result = {}
    Role.all.each do |r|
      @result[r.id] = {:name => r.name, :statuses => r.roles_statuses}
    end
  end
end