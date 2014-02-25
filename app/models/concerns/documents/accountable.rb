module Documents::Accountable
  extend ActiveSupport::Concern

  included do
    attr_accessible :document_attributes
    has_one :document, as: :accountable, dependent: :destroy
    accepts_nested_attributes_for :document

    validates_presence_of :document

    scope :with_state, ->(state) { includes(:document).where('documents.state = ?', state) }

    #TODO @prikha write why is it nessesary instead of moving it to
    #TODO clean after document list is done
    after_initialize :setup_document

    #TODO important! save initial transition inside controller

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