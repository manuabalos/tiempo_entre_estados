class TeeController < ApplicationController
  unloadable

  def index
  	@roles = Role.all
  	
  	@result = {}
  	@roles.each do |r|
	  	@result[r.name] = {:start => [], :pause => [], :close => []}
  		r.tee_prss.each do |prs|
  			@result[r.name][prs.status_type.to_sym] << prs.statuses.name
  		end
  	end
  end
end