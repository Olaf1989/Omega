class Course < ActiveRecord::Base
  has_many :courses_users, :dependent => :destroy
  has_many :users, -> { distinct }, :through => :courses_users
end
