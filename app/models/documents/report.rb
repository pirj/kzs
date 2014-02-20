# coding: utf-8
 module Documents
  class Report < ActiveRecord::Base
    include Accountable

    attr_accessible :order_id, :order

    belongs_to :order

    validates :order_id, presence: { message: 'Акт невозможно создать без распоряжения' }

    def state_machine
      ReportStateMachine.new(self, transition_class: DocumentTransition)
    end

    delegate :can_transition_to?, :transition_to!, :transition_to, :current_state,
             to: :state_machine
  end
end