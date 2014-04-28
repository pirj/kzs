class NotificationMailer < ActionMailer::Base
  default from: "sake@cyclonelabs.net"

  def document_changed user, document, old_document, old_conformers
    @user = user
    @document = document
    @old_document = old_document
    @old_conformers = old_conformers

    @title_changed = true unless document.title == old_document.title
    @body_changed = true unless document.body == old_document.body
    @creator_changed = true unless document.creator_id == old_document.creator_id
    @conformers_changed = true unless document.conformers.to_a == old_conformers
    @executor_changed = true unless document.executor_id == old_document.executor_id
    @approver_changed = true unless document.approver_id == old_document.approver_id

    type = case @document.accountable_type
      when 'Documents::Report' then 'акте'
      when 'Documents::OfficialMail' then 'письме'
      when 'Documents::Order' then 'предписании'
      else 'документе'
    end

    mail to: user.email, subject: "САКЭ КЗС. Изменение в #{type} «#{document.title}»"
  end
end
