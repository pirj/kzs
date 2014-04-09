# coding: utf-8
require 'acceptance/acceptance_helper'

feature "Users sees documents list", %q{} do

  let!(:documents) do
    5.times.map do |i|
      FactoryGirl.create(:mail_with_many_recipients)
    end
  end


  context 'mails' do
    context 'prepared' do
      let!(:accountable) { FactoryGirl.create(:mail_with_direct_recipient_and_conformers) }
      let(:index_path) { documents_documents_path }
      let(:show_path) { polymorphic_path(accountable) }

      it_behaves_like 'document_preparable'

    end

    context 'draft' do
      let!(:accountable) { FactoryGirl.create(:mail_with_direct_recipient) }
      let(:index_path) { documents_documents_path(with_state: 'draft') }
      let(:show_path) { polymorphic_path(accountable) }

      it_behaves_like 'document_draftable'
    end

    context 'approved' do
      let!(:accountable) { FactoryGirl.create(:mail_with_direct_recipient) }
      let(:index_path) { documents_documents_path(with_state: 'approved') }
      let(:show_path) { polymorphic_path(accountable) }

      before do
        accountable.transition_to!(:prepared)
        accountable.transition_to!(:approved)
      end

      it_behaves_like 'document_approvable'
    end

    context 'sent' do
      let!(:accountable) { FactoryGirl.create(:mail_with_direct_recipient) }
      let(:index_path) { documents_documents_path(with_state: 'sent') }
      let(:show_path) { polymorphic_path(accountable) }

      before do
        accountable.transition_to!(:prepared)
        accountable.transition_to!(:approved)
        accountable.transition_to!(:sent)
      end

      it_behaves_like 'document_sendable'
    end
  end
end