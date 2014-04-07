# coding: utf-8
require 'acceptance/acceptance_helper'

feature "Users sees documents list", %q{} do

  let!(:documents) do
    5.times.map do |i|
      FactoryGirl.create(:mail_with_many_recipients)
    end
  end

  let(:list_path) { documents_documents_path }

  context 'mails' do
    let(:document) { FactoryGirl.create(:mail_with_direct_recipient_and_conformers) }

    it_behaves_like 'document_preparable'
  end

end