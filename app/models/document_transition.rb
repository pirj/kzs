class DocumentTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition

  
  attr_accessible :to_state, :metadata, :sort_key
  
  belongs_to :document, inverse_of: :document_transitions


  after_commit :update_status_cache

  private
  def update_status_cache
    document.update_attribute(:state, to_state)
  end
end
