module Documents::AccountableController
  extend ActiveSupport::Concern

  included do
    layout 'base'
    before_filter :assign_read_state_if_director, only: :show
    before_filter :mark_as_read, only: :show
    actions :all, except: [:index]
  end

  def create
    create! do |success, failure|
      success.html do
        if params.has_key?(:transition_to)
          resource.transition_to!(params[:transition_to], default_metadata)
          redirect_to documents_documents_path

        # Когда прикрепляем документы, то сохраняем данный документ в БД. Иначе как крепить файлы то???
        elsif params.has_key?(:attached_documents)
          redirect_to polymorphic_path([resource, :attached_documents])
        end
      end
      failure.html { render action: 'new' }
    end
  end

  def update
    update! do |success, failure|
      success.html do
        resource.transition_to!(params[:transition_to], default_metadata)
        redirect_to documents_path
      end
      failure.html { render action: 'edit' }
    end
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
end
