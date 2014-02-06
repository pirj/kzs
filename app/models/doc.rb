class Doc < ActiveRecord::Base
  attr_accessible :accountable_id, # composition with mail, wirt, act
                  :accountable_type, #
                  :approver_id, # пользователь подписант
                  :body, # текст
                  :executor_id, # пользователь исполнитель
                  :reciever_organisation_id, # организация получатель
                  #:author_id, # пользователь создатель
                  :sender_organisation_id, # организация отправитель
                  :status_cache, #кэш статуса для общей таблицы
                  :title # заголовок(тема)
                  #:signed_at та дата когда документ был подписан(возможно кэш)
                  #

  belongs_to :accountabe, polymorphic: true

  #belongs_to :author, class_name: 'User'
  belongs_to :approver, class_name: 'User'
  belongs_to :executor, class_name: 'User'

  belongs_to :sender_organization, class_name: 'Organization'
  belongs_to :reciever_organization, class_name: 'Organization'

  # TODO: add paranoia - this will handle the destruction

  #TODO: document should have many document attachments

  #TODO: document should have many attached documents

  #TODO: add proper validations

  #TODO: pdf generation logic needs to be changed

end
