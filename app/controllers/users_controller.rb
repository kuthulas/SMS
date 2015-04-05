class UsersController < ApplicationController
	before_filter :authenticate_admin!

	def show
		@user = User.find(params[:id])
	end
	
	def index
		@users = User.all.paginate(:page => params[:page])
	end

	def edit
		@user = User.find(params[:id])
	end
end
