class Ability
  include CanCan::Ability

  def initialize(user)  
    
    alias_action :read, :update, :to => :crud

    #TODO: @babrovka
    # Make use of
    #https://github.com/ryanb/cancan/wiki/Fetching-Records


    #TODO: @babrovka Can switch to this:

    # Documents::OfficialMail
    # Documents::OfficialMailStateMachine

    can :apply_draft,    Documents::OfficialMail, document:{sender_organization_id: user.organization_id}
    can :apply_prepared, Documents::OfficialMail, document:{sender_organization_id: user.organization_id}
    can :apply_approved, Documents::OfficialMail, document:{sender_organization_id: user.organization_id, approver_id: user.id}
    can :apply_sent,     Documents::OfficialMail, document:{sender_organization_id: user.organization_id, approver_id: user.id}
    can :apply_sent,     Documents::OfficialMail, document:{sender_organization_id: user.organization_id, creator_id: user.id}
    can :apply_trashed,  Documents::OfficialMail, document:{sender_organization_id: user.organization_id}

    # Documents::Order
    # Documents::OrderStateMachine

    can :apply_draft,    Documents::Order, document:{sender_organization_id: user.organization_id}
    can :apply_prepared, Documents::Order, document:{sender_organization_id: user.organization_id}
    can :apply_approved, Documents::Order, document:{sender_organization_id: user.organization_id, approver_id: user.id}
    can :apply_accepted, Documents::Order, document:{sender_organization_id: user.organization_id, approver_id: user.id}
    can :apply_rejected, Documents::Order, document:{sender_organization_id: user.organization_id, approver_id: user.id}
    can :apply_sent,     Documents::Order, document:{sender_organization_id: user.organization_id, approver_id: user.id}
    can :apply_sent,     Documents::Order, document:{sender_organization_id: user.organization_id, creator_id: user.id}
    can :apply_trashed,  Documents::Order, document:{sender_organization_id: user.organization_id}

    # Documents::Report
    # Documents::ReportStateMachine

    can :apply_draft,    Documents::Report, document:{sender_organization_id: user.organization_id}
    can :apply_prepared, Documents::Report, document:{sender_organization_id: user.organization_id}
    can :apply_approved, Documents::Report, document:{sender_organization_id: user.organization_id, approver_id: user.id}
    can :apply_sent,     Documents::Report, document:{sender_organization_id: user.organization_id, approver_id: user.id}
    can :apply_sent,     Documents::Report, document:{sender_organization_id: user.organization_id, creator_id: user.id}
    can :apply_trashed,  Documents::Report, document:{sender_organization_id: user.organization_id}
    can :apply_accepted, Documents::Report, document:{recipient_organization_id: user.organization_id}, order: {document:{approver_id: user.id}}
    can :apply_rejected, Documents::Report, document:{recipient_organization_id: user.organization_id}, order: {document:{approver_id: user.id}}

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
