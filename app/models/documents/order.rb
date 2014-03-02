module Documents
  class Order < ActiveRecord::Base
    include Accountable
    attr_accessible :deadline
    has_one :report

    # includes approved_reports for history
    has_one :approved_report, class_name: 'Documents::Report',include: :document, conditions: 'documents.approved_at IS NOT NULL'

    # TODO: @prikha dumb but working history
    # refactor if possible
    belongs_to :conversation, foreign_key: :conversation_id, class_name: 'OrdersConversation'
    has_many :conversation_orders, through: :conversation, source: :orders

    attr_accessible :task_list_attributes
    has_one :task_list, dependent: :destroy
    has_many :tasks, through: :task_list
    accepts_nested_attributes_for :task_list, allow_destroy: true

    scope :completed, ->(){joins(:task_list).where('task_lists.completed' => true)}

    def state_machine
      OrderStateMachine.new(self, transition_class: DocumentTransition)
    end

    delegate :can_transition_to?,
             :transition_to!,
             :transition_to,
             :current_state,
             to: :state_machine

    def history_for(org_id)
      conversation_orders.approved.from_or_to(org_id).includes(:approved_report).order{document.approved_at.desc}
    end
  end
end
