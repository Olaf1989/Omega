class User < ActiveRecord::Base
  has_many :courses_users, :dependent => :destroy
  has_many :courses, -> { distinct }, :through => :courses_users

  rolify
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes["password"] }
  validates :password, confirmation: true, if: -> { new_record? || changes["password"] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes["password"] }
  validates :email, uniqueness: true
  validates :voornaam, :achternaam, :presence => true
end
