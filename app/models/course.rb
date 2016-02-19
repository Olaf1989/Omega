class Course < ActiveRecord::Base
  has_many :courses_users, :dependent => :destroy
  has_many :users, -> { distinct }, :through => :courses_users
  belongs_to :course_type

  validates :begindatum, :einddatum, :cursusduur, :course_type_id, :presence => true

  # Filterrific
  filterrific(
    default_filter_params: { sorted_by: 'begindatum_asc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :with_begindatum,
      :with_einddatum
    ]
  )

  # Aantal curssuen per pagina
  self.per_page = 10

  # Zoekfunctie (uitgeschakeld, maar toch erin gelaten voor de toekomst)
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
     num_or_conditions = 3
     where(
       terms.map {
         or_clauses = [
           "LOWER(courses.course_type.name) LIKE ?",
           "LOWER(courses.created_at) LIKE ?",
           "LOWER(courses.course_type.price) LIKE ?"
         ].join(' OR ')
         "(#{ or_clauses })"
       }.join(' AND '),
       *terms.map { |e| [e] * num_or_conditions }.flatten
     )
   }

   # Sorteren (uitgeschakeld, maar toch erin gelaten voor de toekomst)
  scope :sorted_by, lambda { |sort_option|
  direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
  case sort_option.to_s
    when /^begindatum/
      order("(courses.begindatum) #{ direction }")
    when /^einddatum/
      order("(courses.einddatum) #{ direction }")
    when /^cursusduur/
      order("LOWER(courses.cursusduur) #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
  end
  }

  # Begindatum filter
   scope :with_begindatum, lambda { |ref_date|
     where('courses.begindatum >= ?', reference_time)
   }

   # Einddatum filter
   scope :with_einddatum, lambda { |ref_date|
     where('courses.einddatum <= ?', reference_time)
   }

   # Sorteeropties
   def self.options_for_sorted_by
    [
      ['Begindatum (oplopend)', 'courses.begindatum_asc'],
      ['Begindatum (aflopend)', 'courses.begindatum_desc'],
      ['Einddatum (aflopend)', 'courses.einddatum_asc'],
      ['Einddatum (oplopend)', 'courses.einddatum_desc'],
    ]
  end

  # Begindatum opmaak
  def decoreated_begindatum
    friendly_date_compact begindatum
  end

  # Einddatum opmaak
  def decorated_einddatum
    friendly_date_compact einddatum
  end
end
