class PagesController < ApplicationController

  def home
  	@events = Event.where(date: Date.today..1.month.since)
  end

end
