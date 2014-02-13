module Documents::Base
  #TODO: we can check ability for Mail Order Report or for Document
  def assign_state
    state = params[:state]
    if can?(ability_for(state), resource.document) && resource.transition_to!(state, user_id: current_user.id)
      redirect_to :back, notice: t("document_#{state}")
    else
      redirect_to :back, notice: t('access_denied')
    end
  end
end