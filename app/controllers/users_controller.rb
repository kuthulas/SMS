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

	def update
		@user = User.find(params[:id])
	    respond_to do |format|
	      if @user.update(user_params)
	        format.html { redirect_to @user, notice: 'User was successfully updated.' }
	        format.json { render :show, status: :ok, location: @user }
	      else
	        format.html { render :edit }
	        format.json { render json: @user.errors, status: :unprocessable_entity }
	      end
	    end
    end

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
