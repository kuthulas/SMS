class Student < ActiveRecord::Base
	has_many :checkins
	has_many :events, through: :checkins
	has_many :users, through: :checkins
end
