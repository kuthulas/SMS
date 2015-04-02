# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create(username:'admin', email:'kumaranraman@gmail.com', password:'admin123')

User.create(username:'staff', email:'kuthulas@tamu.edu', password:'staff123')

Event.create(name:'Event', year:'2015', term:'Spring', date:'2015-08-04', location:'SCM', time:'5:00 PM')
Event.create(name:'Presentation', year:'2015', term:'Spring', date:'2015-04-01', location:'Reed', time:'1:00 PM')
Event.create(name:'ECEN DS 2', year:'2015', term:'Winter', date:'2015-04-22', location:'Blocker', time:'3:00 PM')
Event.create(name:'Showcase', year:'2015', term:'Winter', date:'2015-07-16', location:'Zachry', time:'2:00 PM')
Event.create(name:'CIVC DS 4', year:'2015', term:'Fall', date:'2015-06-18', location:'ETB', time:'12:30 PM')
Event.create(name:'New', year:'2015', term:'Fall', date:'2015-05-04', location:'HECC', time:'9:30 AM')

Student.create(fname:'Kumaran', lname: 'Thulasiraman', uin:223003944, email:'kuthulas@tamu.edu', card:'abcdefghij1234567890')
Student.create(fname:'Bob', lname: 'Walker', uin:223003941, email:'mahathi@tamu.edu')
Student.create(fname:'Kevin', lname: 'Mcnaughty' , uin:223003942, email:'kevin@tamu.edu')
Student.create(fname:'Dan', lname: 'Fisher', uin:223003943, email:'dan@tamu.edu')

Checkin.create(event_id: '1', student_id: '1')
Checkin.create(event_id: '1', student_id: '2')
Checkin.create(event_id: '2', student_id: '3')
Checkin.create(event_id: '2', student_id: '4')
Checkin.create(event_id: '3', student_id: '1')
Checkin.create(event_id: '3', student_id: '4')
Checkin.create(event_id: '4', student_id: '3')
Checkin.create(event_id: '4', student_id: '2')
Checkin.create(event_id: '5', student_id: '2')
Checkin.create(event_id: '5', student_id: '3')
Checkin.create(event_id: '6', student_id: '3')
Checkin.create(event_id: '6', student_id: '1')