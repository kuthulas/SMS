class Card < ActiveRecord::Base
 filterrific :default_filter_params => { :sorted_by => 'uin_asc' },
              :available_filters => %w[
                sorted_by
                search_query
              ]
	self.per_page = 10
	

	scope :search_query, lambda { |query|
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.to_s.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 2
    where(
      terms.map {
        or_clauses = [
          "LOWER(cards.uin) LIKE ?",
          "LOWER(cards.number) LIKE ?"
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }
    

    scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
	    when /^uin_/
	      order("LOWER(cards.uin) #{ direction }")
	    when /^number_/
	      order("LOWER(cards.number) #{ direction }")
	    else
	      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  def self.options_for_sorted_by
    [
      ['uin (0-9)', 'uin_asc'],
      ['uin (9-0)', 'uin_desc'],
      ['number (0-9)', 'number_asc'],
      ['number (9-0)', 'number_desc']
      
    ]
  end
  

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
