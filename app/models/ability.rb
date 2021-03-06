class Ability
  include CanCan::Ability

  def initialize(current_user)

    current_user ||= User.new #guest user

    if current_user.admin?
      can :manage, :all
    else
      # Users
      can [:new, :create],  User
      can :show, User do |user_record|
        current_user.id == user_record.id
      end

      # Events
      can [:index, :new, :create], Event
      can [:show, :edit, :update, :destroy], Event do |event|
        event.user == current_user
      end

      # Meals
      can :manage, Meal # Dont have to worry about permissions. Already handled on events.

      # Dishes
      can :manage, Dish # Dont have to worry about permissions. Already handled on events.

      # Supplies
      can :manage, Supply # Dont have to worry about permissions. Already handled on events.

      # Costs
      can :manage, :costs
    end







    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
