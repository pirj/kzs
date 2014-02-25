module Documents::AccountableController
  extend ActiveSupport::Concern

  included do
    layout 'base'
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

  def assign_state
    state = params[:state]
    if can_apply_state?(state, resource) && resource.transition_to!(state, default_metadata)
      redirect_to :back, notice: t("document_#{state}")
    else
      redirect_to :back, notice: t('access_denied')
    end
  end

  private

  def default_metadata
    {user_id: current_user.id}
  end

end