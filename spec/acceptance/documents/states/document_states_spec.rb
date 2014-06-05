require 'acceptance/acceptance_helper'

feature "Users work with documents states", %q() do
  let!(:accountable) { FactoryGirl.create(:mail) }
  let!(:document) { accountable.document }
  let(:user) { FactoryGirl.create(:user_with_organization) }
  let(:path) {  polymorphic_path(accountable) }
  let(:index_path) { documents_documents_path }
  let(:show_path) { polymorphic_path(accountable) }




  it_behaves_like 'document_editable'

  it_behaves_like 'document_draftable'
  context 'with conformers' do
    let!(:accountable) { FactoryGirl.create(:mail_with_direct_recipient_and_conformers) }
    it_behaves_like 'document_preparable'
  end
  it_behaves_like 'document_approvable'
  it_behaves_like 'document_sendable'
  it_behaves_like 'sent_state_translatable'
  it_behaves_like 'document_readable'

end