class Student < ActiveRecord::Base
	has_many :checkins, :dependent => :destroy
	has_many :events, through: :checkins
	has_many :users, through: :checkins

	self.per_page = 10
	attr_accessor :tag_list

	def self.import(file)
  	  	CSV.foreach(file.path, headers: true) do |row|
      		Student.create! row.to_hash
    	end
	end
end
