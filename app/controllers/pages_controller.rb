class PagesController < ApplicationController

  def home
  	if user_signed_in?
  		@events = Event.where(date: Date.today).paginate(:page => params[:page])
  	else
  		@events = Event.where(date: Date.today..1.month.since).paginate(:page => params[:page])
  	end
  end

  def help
  end

end
