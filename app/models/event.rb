class Event < ActiveRecord::Base
  validates_presence_of :name, :kind
  has_many :checkins, :dependent => :destroy
  has_many :students, through: :checkins

	filterrific :default_filter_params => { :sorted_by => 'date_asc' },
              :available_filters => %w[
                sorted_by
                search_query
              ]
	self.per_page = 10

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
    num_or_conditions = 5
    where(
      terms.map {
        or_clauses = [
          "LOWER(events.name) LIKE ?",
          "LOWER(events.term) LIKE ?",
          "LOWER(events.location) LIKE ?",
          "LOWER(events.year) LIKE ?",
          "LOWER(events.typename) LIKE ?"
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
	      order("LOWER(events.name) #{ direction }")
	    when /^location_/
	      order("LOWER(events.location) #{ direction }")
      when /^date_/
        order("events.date #{ direction }")
	    when /^term/
	      order("LOWER(events.term) #{ direction }")
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
