class Documents::OfficialMailsController < ResourceController
  include Documents::AccountableController

  helper_method :history

  def new
    @official_mail = Documents::OfficialMail.new.tap do |mail|
      mail.build_document
    end
    new!
  end

   # TODO: @prikha Move to another controller
  # rubocop:disable LineLength
  def reply
    @parent_official_mail = end_of_association_chain.find(params[:id])

    unless @parent_official_mail.conversation
      @parent_official_mail.create_conversation
      @parent_official_mail.save!
    end

    conversation = @parent_official_mail.conversation

    @official_mail = end_of_association_chain.new.tap do |mail|
      mail.conversation_id = conversation.id
      mail.build_document.tap do |doc|
        doc.recipient_organization = @parent_official_mail.sender_organization
      end
    end
  end
  # rubocop:enable LineLength

  def show
    show! { @official_mail = Documents::ShowDecorator.decorate(resource) }
  end

  def create
    attributes = params[:documents_official_mail]
    @official_mail =
        Documents::OfficialMail.new(attributes).tap do |mail|
          mail.sender_organization = current_organization
          mail.creator = current_user
          mail.executor ||= current_user
        end
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
