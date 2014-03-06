module Documents::Accountable
  extend ActiveSupport::Concern

  included do
    attr_accessible :document_attributes
    has_one :document, as: :accountable, dependent: :destroy
    accepts_nested_attributes_for :document

    validates_presence_of :document

    # rubocop:disable LineLength
    default_scope { includes(:document) }

    scope :with_state, ->(state) { where('documents.state' => state) }

    scope :from, ->(o_id) { where('documents.sender_organization_id' => o_id) }

    scope :to, ->(o_id) { where('documents.recipient_organization_id' => o_id) }

    scope :from_or_to, lambda { |o_id|
      where do
        (document.sender_organization_id.eq(o_id) | document.recipient_organization_id.eq(o_id))
      end
    }

    scope :approved, -> { where { document.approved_at.not_eq(nil) } }

    # rubocop:enable LineLength

    # TODO: @prikha write why is it nessesary instead of moving it to
    # TODO: clean after document list is done
    after_initialize :setup_document

  end

  def allowed_transitions
    states = state_machine.allowed_transitions
    new_record? ? (states - %w(trashed)) : states
  end

  def method_missing(method, *args)
    return document.send(method, *args) if document.respond_to?(method)
    super
  end

  private

  def setup_document
    self.document ||= Document.new
  end
end
