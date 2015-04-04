class PagesController < ApplicationController

  def home
  	@events = Event.where(date: Date.today..1.month.since).paginate(:page => params[:page])
  end

  def help
  end

end
