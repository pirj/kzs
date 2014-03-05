class Documents::OfficialMailsController < ResourceController
  include Documents::AccountableController

  helper_method :history

  def copy
    @parent_official_mail = end_of_association_chain.find(params[:id])

    @official_mail = end_of_association_chain.new
    @official_mail.document = @parent_official_mail.document.safe_clone

    render action: :new
  end

  # rubocop:disable LineLength
  def reply
    @parent_official_mail = end_of_association_chain.find(params[:id])

    unless @parent_official_mail.conversation
      @parent_official_mail.create_conversation
      @parent_official_mail.save!
    end

    conversation = @parent_official_mail.conversation

    @official_mail = end_of_association_chain.new(conversation_id: conversation.id)

    @official_mail.document.assign_attributes(
        sender_organization: current_organization,
        recipient_organization: @parent_official_mail.sender_organization,
        creator: current_user
    )

    # render reply template
    # render action: :new
  end
  # rubocop:enable LineLength

  def show
    show! { @official_mail = Documents::ShowDecorator.decorate(resource) }
  end

  def create
    @official_mail =
        Documents::OfficialMail.new(params[:documents_official_mail])
    @official_mail.sender_organization = current_organization
    @official_mail.creator = current_user
    @official_mail.executor ||= current_user
    super
  end

  def update
    resource.creator = current_user
    resource.executor ||= current_user
    super
  end

  private

  def history
    @history ||=
        Documents::ListDecorator.decorate mail_history,
                                          with: Documents::ListShowDecorator
  end

  def mail_history
    resource.history_for(current_organization.id)
  end
end
