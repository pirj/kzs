module Documents
  class OfficialMail < ActiveRecord::Base
    include Accountable
    attr_accessible :conversation_id, :conversation, :recipient_ids

    belongs_to :conversation,
               class_name: 'DocumentConversation',
               foreign_key: 'conversation_id',
               autosave: true

    has_and_belongs_to_many :recipients, class_name: 'Organization'

    def state_machine
      OfficialMailStateMachine.new(self, transition_class: DocumentTransition)
    end

    delegate :allowed_transitions,
             :can_transition_to?,
             :transition_to!,
             :transition_to,
             :current_state,
             to: :state_machine

    amoeba do
      exclude_field :conversation
      clone :document
    end

    validate :recipients_present?

    private

    def recipients_present?
      msg = I18n.t('activerecord.errors.models.documents.official_mail.attributes.recipient_ids.blank')
      errors.add(:recipient_ids, msg) unless recipients.any?
    end

    # TODO: add paranoia - this will handle the destruction
  end
end
