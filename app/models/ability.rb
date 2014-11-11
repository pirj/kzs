class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :read, :update, to: :crud

    # Создатель может читать свои документы( в том числе и черновики и конфиденциальные)
    can :read, Document, creator_id: user.id
    cannot :update, Document

    # Любой пользователь данной организации может читать неконфиденциальные исходящие документы
    # в состоянии Подписан, Отправлен, Принят, Отклонен
    can :read, Document, confidential: false, sender_organization_id: user.organization_id, state: %w(approved sent approved rejected)

    # Любой пользователь данной организации может читать неконфиденциальные входящие документы
    can :read, Document, confidential: false, recipient_organization_id: user.organization_id, state: %w(sent accepted rejected)

    # Не конфиденциальные исходящие документы в состоянии Подготовлен могут видеть
    # Создатель
    # Исполнитель
    # Согласующие лица
    # Контроллирующее лицо
    can :read, Document, confidential: false, state: 'prepared', executor_id: user.id
    can :read, Document, confidential: false, state: 'prepared', approver_id: user.id
    can :read, Document, :confidential => false, :state => 'prepared', :conformers.outer => { id: user.id }


    # Конфиденциальные исходящие документы может могут читать Составитель, Исполнитель, Контроллирующее Лицо и Согласующие Лица.
    #can :read, Document, confidential: true, sender_organization_id: user.organization_id, creator_id: user.id
    can :read, Document, confidential: true, sender_organization_id: user.organization_id, approver_id: user.id
    can :read, Document, confidential: true, sender_organization_id: user.organization_id, executor_id: user.id
    can :read, Document, :confidential => true, :conformers.outer => { id: user.id }

    # Директор может читать входящие и исходящие документы
    if user.director?
      can :read, Document, sender_organization_id: user.organization_id
      can :read, Document, recipient_organization_id: user.organization_id, state: %w(sent accepted rejected)
    end

    # Только Составитель, Исполнитель, Контроллирующее лицо могут редактировать документ
    can :update, Document, creator_id: user.id
    can :update, Document, executor_id: user.id
    can :update, Document, approver_id: user.id

    can :reply_to, Documents::OfficialMail, document: { recipient_organization_id: user.organization_id }

    # TODO: @babrovka
    # Make use of
    # https://github.com/ryanb/cancan/wiki/Fetching-Records

    # TODO: @babrovka Can switch to this:

    # Documents::OfficialMail
    # Documents::OfficialMailStateMachine

    can :apply_draft,    Documents::OfficialMail, document: { sender_organization_id: user.organization_id }
    can :apply_prepared, Documents::OfficialMail, document: { sender_organization_id: user.organization_id }
    can :apply_approved, Documents::OfficialMail, document: { sender_organization_id: user.organization_id, approver_id: user.id }
    can :apply_sent,     Documents::OfficialMail, document: { sender_organization_id: user.organization_id, approver_id: user.id }
    can :apply_trashed,  Documents::OfficialMail, document: { sender_organization_id: user.organization_id }

    # Documents::Order
    # Documents::OrderStateMachine

    can :apply_draft,    Documents::Order, document: { sender_organization_id: user.organization_id }
    can :apply_prepared, Documents::Order, document: { sender_organization_id: user.organization_id }
    can :apply_approved, Documents::Order, document: { sender_organization_id: user.organization_id, approver_id: user.id }
    can :apply_sent,     Documents::Order, document: { sender_organization_id: user.organization_id, approver_id: user.id }
    can :apply_trashed,  Documents::Order, document: { sender_organization_id: user.organization_id }

    # Documents::Report
    # Documents::ReportStateMachine

    can :apply_draft,    Documents::Report, document: { sender_organization_id: user.organization_id }
    can :apply_prepared, Documents::Report, document: { sender_organization_id: user.organization_id }
    can :apply_approved, Documents::Report, document: { sender_organization_id: user.organization_id, approver_id: user.id }
    can :apply_sent,     Documents::Report, document: { sender_organization_id: user.organization_id, approver_id: user.id }
    can :apply_trashed,  Documents::Report, document: { sender_organization_id: user.organization_id }

    can :apply_accepted, Documents::Report, document: { recipient_organization_id: user.organization_id }, order: { document: { approver_id: user.id } }
    can :apply_rejected, Documents::Report, document: { recipient_organization_id: user.organization_id }, order: { document: { approver_id: user.id } }

    can :create, Permit if user.permissions.exists?('6')

    can :conform, Document do |doc|
        doc.conformers.include?(user) && !user.made_decision?(doc)
    end

    ### Модуль «Задачи»

    # Инспектор может редактировать все аттрибуты задачи
    # can :edit_attributes, Tasks::Task, inspector_id: user.id

    # Инспектор или исполнитель могут редактировать контрольные списки (чеклисты)
    # can :edit_checklists, Tasks::Task, inspector_id: user.id
    # can :edit_checklists, Tasks::Task, executor_id: user.id

    # Исполнитель может начать задачу
    # can :start, Tasks::Task, executor_id: user.id

    # Исполнитель может закончить задачу
    # can :finish, Tasks::Task, executor_id: user.id

    # Исполнитель может поставить задачу на паузу
    # can :pause, Tasks::Task, executor_id: user.id

    # Исполнитель может возобновить выполнение задачи
    # can :resume, Tasks::Task, executor_id: user.id

    # Инспектор может переформулировать задачу
    # can :reformulate, Tasks::Task, inspector_id: user.id

    # Инспектор может отменить задачу
    # can :cancel, Tasks::Task, inspector_id: user.id

    ### / Модуль «Задачи»
    

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
        can :crud, Organization, id: user.organization_id
        can :manage, User, organization_id: user.organization_id
      else
        cannot :read, Organization
        cannot :read, User
      end
    end
  end
end
