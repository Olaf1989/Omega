class Course < ActiveRecord::Base
  has_many :courses_users, :dependent => :destroy
  has_many :users, -> { distinct }, :through => :courses_users
  belongs_to :course_type

  validates :begindatum, :einddatum, :cursusduur, :course_type_id, :presence => true
end
