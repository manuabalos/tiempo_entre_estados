class TeePrsController < ApplicationController
  unloadable
  def index
  	# Hay que recoger los estados de inicio y de fin para ese usuario y poder modificarlos
  	@user = User.find params[:user_id]
  	@statuses = IssueStatus.select(:name).uniq.map{|status| status.name}
  end
end