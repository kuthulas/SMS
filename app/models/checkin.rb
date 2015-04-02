class Checkin < ActiveRecord::Base
	belongs_to :student
	belongs_to :event
	belongs_to :user
end
