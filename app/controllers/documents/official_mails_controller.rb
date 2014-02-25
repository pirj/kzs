class Documents::OfficialMailsController < ResourceController
  include Documents::AccountableController

  def copy
    @parent_official_mail = end_of_association_chain.find(params[:id])

    @official_mail = end_of_association_chain.new
    @official_mail.document = @parent_official_mail.document.safe_clone

    render action: :new
  end

  def reply
    @parent_official_mail = end_of_association_chain.find(params[:id])
    @official_mail = end_of_association_chain.new(conversation: conversation)

    conversation =
        @parent_official_mail.conversation || @parent_official_mail.create_conversation

    @official_mail.document.assign_attributes(
        sender_organization: current_organization,
        recipient_organization: @parent_official_mail.sender_organization)

    render action: :new
  end

  def show
    show!{ @official_mail = Documents::ShowDecorator.decorate(resource) }
  end

  def create
    @official_mail =
        Documents::OfficialMail.new(params[:documents_official_mail])
    @official_mail.sender_organization = current_organization
    super
  end
end