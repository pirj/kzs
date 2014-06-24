class NotificationMailer < ActionMailer::Base
  default from: "sake@cyclonelabs.net"

  # TODO: refactor using ActiveModel::Dirty methods
  def document_changed user, document, old_document, old_conformers
    @user = user
    @document = document
    @old_document = old_document
    @old_conformers = old_conformers

    @old_conformers_names = @old_conformers.map{|user| [user.last_name, user.first_name].join(' ') }.join(', ')
    @conformers_names = conformers = @document.conformers.to_a.map{|user| [user.last_name, user.first_name].join(' ') }.join(', ')

    @title_changed = true unless document.title == old_document.title
    @body_changed = true unless document.body == old_document.body
    @creator_changed = true unless document.creator_id == old_document.creator_id
    @conformers_changed = true unless document.conformers.to_a == old_conformers
    @executor_changed = true unless document.executor_id == old_document.executor_id
    @approver_changed = true unless document.approver_id == old_document.approver_id

    mail to: user.email, subject: "САКЭ КЗС. Изменение в документе «#{document.title}»"
  end

  def document_conformed document
    @document = document
    mail to: document.approver.email, subject: "САКЭ КЗС. Документ «#{document.title}» согласован и готов к подписи"
  end

  def task_created user, task
    @user = user
    @task = task

    mail to: user.email, subject: "САКЭ КЗС. Новая задача «#{task.title}»"
  end

  def task_changed user, task
    @user = user
    @task = task
    @changed = task.changed

    mail to: user.email, subject: "САКЭ КЗС. Изменение в задаче «#{task.title}»"
  end

  def task_state_changed user, task
    @user = user
    @task = task

    mail to: user.email, subject: "САКЭ КЗС. Статус задачи «#{task.title}» изменился на «#{I18n.t("activerecord.tasks/task.state.#{task.current_state}")}»"
  end

  def task_checklist_item_changed user, item
    @item = item

    mail to: user.email, subject: "САКЭ КЗС. Статус дела «#{item.name}» изменился"
  end

end
