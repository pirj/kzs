module Documents
  class OfficialMail < ActiveRecord::Base
    include Accountable
    attr_accessible :conversation_id, :conversation, :recipient_ids, :recipients

    belongs_to :conversation,
               class_name: 'DocumentConversation',
               foreign_key: 'conversation_id',
               autosave: true

    has_many :conversation_mails, through: :conversation, source: :official_mails

    has_and_belongs_to_many :recipients, class_name: 'Organization'

    def history_for(o_id)
      conversation_mails.
          includes{document}.
          where do
        (document.sender_organization_id.eq(o_id)) |
        ((document.state.in %w(sent read)) & document.recipient_organization_id.eq(o_id))
      end
    end

    def state_machine
      OfficialMailStateMachine.new(self, transition_class: DocumentTransition)
    end

    delegate :can_transition_to?,
             :transition_to!,
             :transition_to,
             :current_state,
             to: :state_machine

    amoeba do
      exclude_field :conversation
      clone :document
    end

    validate :recipients_present?

    # actual methods for one instance of Model
    def single_applicable_actions
      %w(edit reply)
    end

    private

    def recipients_present?
      msg = I18n.t('activerecord.errors.models.documents.official_mail.attributes.recipient_ids.blank')
      errors.add('documents/official_mail.recipient_ids', msg) unless recipients.any?
    end

    # TODO: add paranoia - this will handle the destruction
  end
end
