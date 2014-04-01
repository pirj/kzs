module Documents
  class Order < ActiveRecord::Base
    include Accountable
    attr_accessible :deadline
    attr_accessible :task_list_attributes

    has_one :report

    has_one :task_list, dependent: :destroy

    has_many :tasks, through: :task_list

    accepts_nested_attributes_for :task_list, allow_destroy: true

    validates_presence_of :task_list

    validates :deadline, timeliness: {
      on_or_after: -> { DateTime.now + 3.days },
      type: :date
    }

    def state_machine
      OrderStateMachine.new(self, transition_class: DocumentTransition)
    end

    delegate :can_transition_to?,
             :transition_to!,
             :transition_to,
             :current_state,
             to: :state_machine

    amoeba do
      clone :document
    end

    def completed?
      task_list && task_list.completed
    end
  end
end
