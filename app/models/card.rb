class Card < ActiveRecord::Base
 def self.import(file)
	CSV.foreach(file.path, headers: true) do |row|
		Card.create! row.to_hash
 	end
 end

 def term
 	student = Student.find_by(uin: uin)
	if(student)
	 return student.term
	else
	 return ""
	end
 end

 def year
 	student = Student.find_by(uin: uin)
	if(student)
	 return student.year
	else
	 return ""
	end
 end

end
