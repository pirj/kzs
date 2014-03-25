class DocumentTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition

  attr_accessible :to_state, :metadata, :sort_key

  belongs_to :document, inverse_of: :document_transitions

  after_commit :update_status_cache

  private

  def update_status_cache
    document.update_column(:state, to_state)
    document.update_column(:updated_at, Time.now)
  end
end
