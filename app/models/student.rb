class Student < ActiveRecord::Base
	validates_presence_of :fname, :lname, :email
	validates_length_of :uin, :is => 9, :allow_blank => true
	validates_format_of :fname, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/
	validates_format_of :lname, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/
	
	has_many :checkins, :dependent => :destroy
	has_many :events, through: :checkins

	self.per_page = 10
	attr_accessor :tag_list

	def self.import(file)
  	  	CSV.foreach(file.path, headers: true) do |row|
      		Student.create! row.to_hash
    	end
	end
end
