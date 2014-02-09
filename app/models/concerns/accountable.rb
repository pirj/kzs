module Accountable
  extend ActiveSupport::Concern

  included do
    attr_accessible :document_attributes
    has_one :document, as: :accountable, class_name: 'Doc', dependent: :destroy
    accepts_nested_attributes_for :document
  end

  def method_missing(method, *args)
    return document.send(method, *args) if document.respond_to?(method)
    super
  end

end