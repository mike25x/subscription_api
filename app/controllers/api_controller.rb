class ApiController < ApplicationController

	def index
		render :text => "<b>status:</b><label style='color:blue'> up and running</label>"
	end
end
