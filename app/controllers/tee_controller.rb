class TeeController < ApplicationController
  unloadable

  def index
  	@users = User.all # provisonal
  	# Hay que recoger los estados de inicio y de fin de cada usaurio
  end
end