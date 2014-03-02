module Documents::AccountableController
  extend ActiveSupport::Concern

  included do
    layout 'base'
    before_filter :mark_as_read, only: :show
    actions :all, except: [:index]
  end

  def create
    create! do |success, failure|
      success.html do
        resource.transition_to!(params[:transition_to], default_metadata)
        redirect_to documents_documents_path
      end
      failure.html { render action: 'new' }
    end
  end

  def update
    update! do |success, failure|
      success.html do
        resource.transition_to!(params[:transition_to], default_metadata)
        redirect_to documents_documents_path
      end
      failure.html { render action: 'new' }
    end
  end

# rubocop:disable LineLength
  def assign_state
    state = params[:state]
    if can_apply_state?(state, resource) && resource.transition_to!(state, default_metadata)
      redirect_to :back, notice: t("document_#{state}")
    else
      redirect_to :back, notice: t('access_denied')
    end
  end
# rubocop:enable LineLength

  private

  def default_metadata
    { user_id: current_user.id }
  end

  def mark_as_read
    if can_mark_as_read?
      document = resource.document
      document.update_column(:read_at, Time.now)
    end
  end

  def can_mark_as_read?
    resource.recipient_organization &&
    resource.recipient_organization.director == current_user
  end
end
