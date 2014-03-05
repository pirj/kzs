module Documents
  class OfficialMail < ActiveRecord::Base
    include Accountable
    attr_accessible :conversation_id,
                    :conversation,
                    :recipient_ids,
                    :recipients

    belongs_to :conversation,
               class_name: 'DocumentConversation',
               foreign_key: 'conversation_id'

    has_many :conversation_mails,
             through: :conversation,
             source: :official_mails

    has_and_belongs_to_many :recipients,
                            class_name: 'Organization'

    validate :recipients_present?

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

    def history_for(o_id)
      conversation_mails
        .approved
        .from_or_to(o_id)
        .order { document.approved_at.desc }
    end

    # TODO-justvitalius: please, get it from here
    # actual methods for one instance of Model
    def single_applicable_actions
      array = %w(reply)
      if %w(draft prepared).include?(accountable.current_state)
        array += %w(edit)
      end
      array
    end

    private

    # rubocop:disable LineLength
    def recipients_present?
      msg = I18n.t('activerecord.errors.models.documents.official_mail.attributes.recipient_ids.blank')
      unless recipient_organization || recipients.any?
        errors.add('recipient_ids', msg)
      end
    end
    # rubocop:enable LineLength
  end
end
