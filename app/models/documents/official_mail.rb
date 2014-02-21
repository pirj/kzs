module Documents
  class OfficialMail < ActiveRecord::Base
    include Accountable
    attr_accessible :conversation_id, :conversation

    belongs_to :conversation, class_name: 'DocumentConversation', foreign_key: 'conversation_id', autosave: true

    def state_machine
      OfficialMailStateMachine.new(self, transition_class: DocumentTransition)
    end

    delegate :allowed_transitions, :can_transition_to?, :transition_to!, :transition_to, :current_state,
             to: :state_machine

    has_and_belongs_to_many :recipients, class_name: 'Organization'

    amoeba do
      exclude_field :conversation
      clone :document
    end

    #TODO: validate recipients or recipient_organization to be present

    private
    # TODO: add paranoia - this will handle the destruction
  end
end

