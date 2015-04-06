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

	def destroy
		@user = User.find(params[:id])
	    @user.destroy
	    respond_to do |format|
	      format.html { redirect_to :back, notice: 'User was successfully destroyed.' }
	      format.json { head :no_content }
	    end
	  end
end
