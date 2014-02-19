class DocumentTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition

  
  attr_accessible :to_state, :metadata, :sort_key
  
  belongs_to :document, inverse_of: :document_transitions

  # TODO think of moving it to Documents::StateMachine superclass
  # and turning it into after_transition block
  after_commit :update_status_cache

  private
  def update_status_cache
    document.update_column(:state, to_state)
  end
end
