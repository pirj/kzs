class Documents::MailsController < ResourceController
  layout 'base'
  actions :all, except: [:index]

  #TODO: we can check ability for Mail Order Report or for Document
  def assign_state
    state = params[:state]
    if can?(ability_for(state), resource.document) && resource.transition_to!(state)
      redirect_to :back, notice: t("document_#{state}")
    else
      redirect_to :back, notice: t('access_denied')
    end
  end

  def reply
    @parent_mail = end_of_association_chain.find(params[:id])
    @mail = end_of_association_chain.new(conversation: @parent_mail.conversation)
    @mail.document.assign_attributes(sender_organization: current_organization,
                                      recipient_organization: @parent_mail.sender_organization)

    render action: :new
  end
end