module Documents
  class Order < ActiveRecord::Base
    include Accountable
    attr_accessible :deadline
    attr_accessible :task_list_attributes

    has_one :report

    # includes approved_reports for history
    has_one :approved_report,
            class_name: 'Documents::Report',
            include: :document,
            conditions: 'documents.approved_at IS NOT NULL'

    has_one :task_list, dependent: :destroy

    # TODO: @prikha dumb but working history
    # refactor if possible
    belongs_to :conversation,
               foreign_key: :conversation_id,
               class_name: 'OrdersConversation'

    has_many :conversation_orders,
             through: :conversation,
             source: :orders


    has_one :task_list, dependent: :destroy

    has_many :tasks, through: :task_list

    accepts_nested_attributes_for :task_list, allow_destroy: true

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
      exclude_field :conversation
      clone :document
    end

    def completed?
      task_list && task_list.completed
    end

    def history_for(o_id)
      conversation_orders
        .approved
        .from_or_to(o_id)
        .includes(:approved_report)
        .order { document.approved_at.desc }
    end



  end
end
