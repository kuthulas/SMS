class Student < ActiveRecord::Base
	validates_presence_of :fname, :lname, :email
	validates_length_of :uin, :is => 9, :allow_blank => true
	validates_format_of :fname, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/
	validates_format_of :lname, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/
	
	has_many :checkins, :dependent => :destroy
	has_many :events, through: :checkins
	
	filterrific :default_filter_params => { :sorted_by => 'fname_asc' },
              :available_filters => %w[
                sorted_by
                search_query
                with_uin
                with_fname
                with_lname
                with_term
                with_year
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
    num_or_conditions = 5
    where(
      terms.map {
        or_clauses = [
          "LOWER(students.uin) LIKE ?",
          "LOWER(students.fname) LIKE ?",
          "LOWER(students.lname) LIKE ?",
          "LOWER(students.email) LIKE ?",
          "LOWER(students.year) LIKE ?"
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
	      order("LOWER(students.uin) #{ direction }")
	    when /^fname_/
	      order("LOWER(students.fname) #{ direction }")
      when /^lname_/
        order("LOWER(students.lname) #{ direction }")
	    when /^email/
	      order("LOWER(students.email) #{ direction }")
      when /^term_/
        order("LOWER(students.term) #{ direction }")
      when /^year/
        order("LOWER(students.year) #{ direction }")
	    else
	      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end

  }

  def self.options_for_sorted_by
    [
      ['uin (0-9)', 'uin_asc'],
      ['uin (9-0)', 'uin_desc'],
      ['First Name (a-z)', 'fname_asc'],
      ['First Name (z-a)', 'fname_desc'],
      ['Last Name (a-z)', 'lname_asc'],
      ['Last Name (z-a)', 'lname_desc'],
      ['Term (a-z)', 'term_asc'],
      ['Term (z-a)', 'term_desc'],
      ['Year (0-9)', 'year_asc'],
      ['Year (9-0)', 'year_desc']
    ]
  end
  
  scope :with_uin, lambda { |uin|
    where(:uin => [*uin])
  }

  scope :with_fname, lambda { |fname|
    where(:fname => [*fname])
  }

  scope :with_lname, lambda { |lname|
    where(:lname => [*lname])
  }

  scope :with_term, lambda { |term|
    where(:term => [*term])
  }

  scope :with_year, lambda { |year|
    where(:year => [*year])
  }
  def self.options_for_uin_select
    Student.uniq.pluck(:uin)
  end

  def self.options_for_fname_select
    Student.uniq.pluck(:fname)
  end

  def self.options_for_lname_select
    Student.uniq.pluck(:lname)
  end
  
  def self.options_for_term_select
    Student.uniq.pluck(:term)
  end

  def self.options_for_year_select
    Student.uniq.pluck(:year)
  end


	def self.import(file)
  	  	CSV.foreach(file.path, headers: true) do |row|
      		Student.create! row.to_hash
    	end
	end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
    csv << column_names
    all.each do |checkin|
      csv << checkin.attributes.values_at(*column_names)
    end
  end
  end
end
