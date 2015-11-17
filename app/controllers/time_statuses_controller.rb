class TimeStatusesController < ApplicationController
  unloadable

  def index
  	@users = User.all # provisonal
  	# Hay que recoger los estados de inicio y de fin de cada usaurio
  end

  def profilestatuses
  	# Hay que recoger los estados de inicio y de fin para ese usuario y poder modificarlos
  	@user = User.find params[:user_id]
  	@statuses = IssueStatus.select(:name).uniq.map{|status| status.name}
  
  	render 'profilestatuses.html.erb'
  end

  def createcalendar
    @users = User.all
  	render 'createcalendar.html.erb'
  end

end