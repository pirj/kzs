module Accountable
  extend ActiveSupport::Concern

  included do
    attr_accessible :document_attributes
    has_one :document, as: :accountable, dependent: :destroy
    accepts_nested_attributes_for :document

    validates_presence_of :document

    after_initialize :setup_document
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