# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create(username:'admin', email:'kumaranraman@gmail.com', password:'admin123')

User.create(username:'staff', email:'kuthulas@tamu.edu', password:'staff123')

require 'faker'
include Faker

@terms = ["Spring", "Fall", "Summer", "Winter"]
@event_types = ["Dept", "Industrial"]
@event_type_details = ["Chemical","CSE", "Petroleum", "Oil and Energy", "Defense"]

50.times do |variable|
	Event.create(name: Lorem.word, year:'2015', term: @terms.sample , date: I18n.localize(Faker::Date.between(2.days.ago, 150.days.since)), location:Address.state_abbr, time:I18n.localize(Faker::Time.between(2.days.ago, Time.now), format: "%I:%M %p"), type: @event_types[Lorem.word.length % @event_types.length], typename: @event_types[Lorem.word.length % @event_types.length])
	@fname = Name.first_name
	Student.create(fname:@fname, lname: Name.last_name, uin:Number.number(9).to_s, email:[@fname.downcase, "@tamu.edu"].join(""), card:Code.ean)
end

50.times do |variable|
	Checkin.create(event_id: rand(1..50), student_id: rand(1..50), user_id: rand(1..1))
end
