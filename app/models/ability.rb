class Ability
  include CanCan::Ability

  def initialize(user)
    # Guest user (not logged in)
    user ||= User.new

    # Cursist
    if user.has_role? :cursist
      can :read, Course
      can [:show, :edit, :update, :destroy], User, :user_id => @current_user_id

    # Teacher / employee
    elsif user.has_role? :teacher
      can :manage, Course
      can [:show, :edit, :update, :destroy], User, :user_id => @current_user_id

    # Admin
    elsif user.has_role? :admin
      can :manage, :all
    end
  end
end

# See the wiki for details:
# https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
