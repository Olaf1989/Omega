class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :cursist
      can :read, Course
    elsif user.has_role? :teacher
      can :manage, Course
    elsif user.has_role? :admin
      can :manage, :all
    end
  end
end

# See the wiki for details:
# https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
