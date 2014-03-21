module Documents::Accountable
  extend ActiveSupport::Concern

  included do
    attr_accessible :document_attributes
    has_one :document, as: :accountable, dependent: :destroy
    accepts_nested_attributes_for :document

    validates_presence_of :document

    # rubocop:disable LineLength
    default_scope includes(:document)

    scope :with_state, ->(state) { where('documents.state' => state) }

    scope :from, ->(o_id) { where('documents.sender_organization_id' => o_id) }

    scope :to, ->(o_id) { where('documents.recipient_organization_id' => o_id) }

    scope :from_or_to, lambda { |o_id|
      where do
        (document.sender_organization_id.eq(o_id) |
            (document.recipient_organization_id.eq(o_id) & document.state.in(%w(sent accepted rejected))))
      end
    }

    scope :approved, -> { where { document.approved_at.not_eq(nil) } }

    # rubocop:enable LineLength

  end

  def allowed_transitions
    states = state_machine.allowed_transitions
    new_record? ? (states - %w(trashed)) : states
  end

  def method_missing(method, *args)
    self.document ||= Document.new
    return document.send(method, *args) if document.respond_to?(method)
    super
  end
end
