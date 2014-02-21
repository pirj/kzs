# coding: utf-8
module Documents
  class Report < ActiveRecord::Base
    include Accountable

    attr_accessible :order_id, :order

    belongs_to :order

    validates_presence_of :order_id

    def state_machine
      ReportStateMachine.new(self, transition_class: DocumentTransition)
    end

    delegate :can_transition_to?,
             :allowed_transitions,
             :transition_to!,
             :transition_to,
             :current_state,
             to: :state_machine
  end
end
