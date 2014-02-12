class Documents::OfficialMailsController < ResourceController
  include Documents::Base

  layout 'base'
  actions :all, except: [:index]



  def reply
    @parent_official_mail = end_of_association_chain.find(params[:id])
    conversation =  @parent_official_mail.conversation || @parent_official_mail.create_conversation
    @official_mail = end_of_association_chain.new(conversation: conversation)
    @official_mail.document.assign_attributes(sender_organization: current_organization,
                                      recipient_organization: @parent_official_mail.sender_organization)

    render action: :new
  end
end