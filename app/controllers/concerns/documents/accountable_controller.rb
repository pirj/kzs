module Documents::AccountableController
  extend ActiveSupport::Concern

  included do
    layout 'base'

    # Проверяем права ползователя на чтение соответствующего документа
    before_filter :authorize_to_read_document, only: :show
    # Проверяем права ползователя на редактирование соответствующего документа
    before_filter :authorize_to_update_document, only: [:edit, :update]

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to documents_path, :flash => { :error => exception.message }
    end

    before_filter :assign_read_state_if_director, only: :show
    before_filter :mark_as_read, only: :show
    before_filter :clear_notifications, only: :show
    actions :all, except: [:index]
  end

  # TODO: @prikha remove if-else mess.
  def create
    create! do |success, failure|
      success.html do
        # Посылаем уведомления исполнителю, контрольному лицу, всем согласующим
        # (если кто-то из вышеперечисленных - текущий юзер (создатель), ему не посылаем)
        resource.notify_interested exclude: current_user

        # Обычное сохранение - нажата кнопка перевода статуса ("Подготовить" или "В черновик")
        if params.has_key?(:transition_to)
          resource.transition_to!(params[:transition_to], default_metadata)
          redirect_to documents_documents_path

        # Нажата кнопка "Прикрепить документы". В этом случае сохраняем документ как черновик и переадресуем на другую страницу
        elsif params.has_key?(:attached_documents)
          resource.transition_to!(:draft, default_metadata)
          redirect_to polymorphic_path([resource, :attached_documents])
        end
      end
      failure.html { render action: 'new' }
    end
  end

  def edit
    resource.document.update_attribute(:creator, current_user)
    resource.document.clear_conformations
  end

  def update
    old_resource = resource.dup
    old_document = resource.document.dup

    update! do |success, failure|
      success.html do

        # Отправляем письмо об изменениях
        # - всем старым согласующим
        # - старому исполнителю
        # - новому исполнителю
        # - старому контрольному лицу
        # - новому контрольному лицу
        mailing_list = (old_document.conformers.to_a.concat(resource.conformers.to_a) << old_document.executor << resource.executor << old_document.approver << resource.approver).uniq

        mailing_list.each do |user|
          NotificationMailer.document_changed(user, resource.document, old_document).deliver!
        end

        # Посылаем уведомления всем, кроме создателя и текущего пользователя
        resource.clear_notifications
        resource.reload.notify_interested except: :creator, exclude: current_user, include: old_list, mailer: NotificationMailer, mail: "document_changed"
        
        resource.transition_to!(params[:transition_to], default_metadata)
        redirect_to documents_path
      end
      failure.html { render action: 'edit' }
    end
  end

  # рендерим pdf документ с помощью pdfjs
  def pdf
    render 'documents/application/pdf', layout: false
  end

  private

  def default_metadata
    { user_id: current_user.id }
  end

  def assign_read_state_if_director
    if director?
      document = resource.document
      document.update_column(:read_at, Time.now)
    end
  end

  def director?
    resource.recipient_organization &&
    resource.recipient_organization.director == current_user
  end

  def mark_as_read
    resource.mark_as_read!(for: current_user)
  end

  def clear_notifications
    resource.clear_notifications for: current_user
  end

  def authorize_to_read_document
    authorize! :read, resource.document, message: I18n.t('unauthorized.read.document')
  end

  def authorize_to_update_document
    authorize! :update, resource.document, message: I18n.t('unauthorized.read.document')
  end
end
