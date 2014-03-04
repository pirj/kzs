require 'acceptance/acceptance_helper'

feature 'orders form field show', %q{} do
  let(:path) {'new_documents_order'}

  describe '.spec-order-field-show' do
    it 'placeholder' do
      visit path
      
    end
  end



