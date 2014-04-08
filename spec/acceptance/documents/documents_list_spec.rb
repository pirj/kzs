# coding: utf-8
require 'acceptance/acceptance_helper'

feature "Users sees documents list", %q{} do

  let!(:documents) do
    5.times.map do |i|
      FactoryGirl.create(:mail_with_many_recipients)
    end
  end


  context 'mails' do
    #context 'prepared' do
    #  let!(:document) { FactoryGirl.create(:mail_with_direct_recipient_and_conformers) }
    #  let(:list_path) { documents_documents_path }
    #
    #  it_behaves_like 'document_preparable'
    #
    #end

    context 'draft' do
      let!(:document) { FactoryGirl.create(:mail_with_direct_recipient) }
      let(:list_path) { documents_documents_path(with_state: 'draft') }

      it_behaves_like 'document_draftable'
    end
  end

end