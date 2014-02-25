module Documents
  class Order < ActiveRecord::Base
    include Accountable
    attr_accessible :deadline
    has_one :report

    attr_accessible :task_list_attributes
    has_one :task_list, dependent: :destroy
    has_many :tasks, through: :task_list
    accepts_nested_attributes_for :task_list, allow_destroy: true

    def state_machine
      OrderStateMachine.new(self, transition_class: DocumentTransition)
    end

    delegate :can_transition_to?,
             :transition_to!,
             :transition_to,
             :current_state,
             to: :state_machine


  end
end
