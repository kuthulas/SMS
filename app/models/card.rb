class Card < ActiveRecord::Base
 def self.import(file)
	CSV.foreach(file.path, headers: true) do |row|
		Card.create! row.to_hash
 	end
 end
end
