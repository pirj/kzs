module Documents
  class OfficialMail < ActiveRecord::Base
    include Accountable
    attr_accessible :recipient_ids,
                    :recipients

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
      clone :document
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

    def recipients_present?
      msg = I18n.t('activerecord.errors.models.documents.official_mail.attributes.recipient_ids.blank')
      unless recipient_organization || recipients.any?
        errors.add('recipient_ids', msg)
      end
    end
  end
end
