class Ability
  include CanCan::Ability

  def initialize(user)  
    
    alias_action :read, :update, :to => :crud

    can :approve, Document if user.permissions.exists?('1')    
    can :create, Permit if user.permissions.exists?('6')

    if user.sys_user
      can :manage, User
      can :manage, Group
      can :manage, Permit
      can :manage, Organization
      can :manage, User
      can :manage, Vehicle
    else
      if user.permissions.exists?('10')
        can :manage, Organization
      elsif user.organization_id
        can :crud, Organization, :id => user.organization_id
        can :manage, User, :organization_id => user.organization_id
      else
        cannot :read, Organization
        cannot :read, User
      end
    end
  end
end
