class Checkin < ActiveRecord::Base
	belongs_to :student
	belongs_to :event
	belongs_to :user

	self.per_page = 10

	filterrific :available_filters => %w[
                sorted_by
                search_query
              ]
    scope :search_query, lambda { |query|
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 6
    where(
      terms.map {
        or_clauses = [
          "LOWER(checkins.event.name) LIKE ?",
          "LOWER(checkins.event.term) LIKE ?",
          "LOWER(checkins.event.location) LIKE ?",
          "LOWER(checkins.student.fname) LIKE ?",
          "LOWER(checkins.student.lname) LIKE ?",
          "LOWER(checkins.student.uin) LIKE ?"
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
	    when /^name_/
	      order("LOWER(checkins.event.name) #{ direction }")
	    when /^location_/
	      order("LOWER(checkins.event.location) #{ direction }")
      when /^date_/
        order("checkins.event.date #{ direction }")
	    when /^term/
	      order("LOWER(checkins.event.term) #{ direction }")
	    else
	      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc'],
      ['Name (z-a)', 'name_desc'],
      ['Location (a-z)', 'location_asc'],
      ['Location (z-a)', 'location_desc'],
      ['Term (a-z)', 'term_asc'],
      ['Term (z-a)', 'term_desc']
    ]
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
