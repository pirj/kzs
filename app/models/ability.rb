class Ability
  include CanCan::Ability

  def initialize(user)  
    
    can :approve, Document if user.permissions.exists?('1')    
    can :create, Permit if user.permissions.exists?('6')
    
    
    
    
    if user.sys_user
      can :manage, User
      can :manage, Organization
    else
      can :manage, User, :id => user.id
      can :manage, Organization, :id => user.organization_id
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
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
