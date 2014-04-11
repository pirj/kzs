require 'acceptance/acceptance_helper'

feature "Users view states for Official Mail", %q() do
  let!(:accountable) { FactoryGirl.create(:mail_with_direct_recipient) }
  let!(:document) { accountable.document }
  let(:user) { FactoryGirl.create(:user) }
  let(:recipient_user) { document.recipient_organization.director }
  let(:sender_user) { document.sender_organization.director }
  let(:path) {  polymorphic_path(accountable) }
  let(:index_path) { documents_documents_path }
  let(:show_path) { polymorphic_path(accountable) }

  # background do
  #   visit path
  #   sign_in_with sender_user.email, 'password'
  # end

  # it_behaves_like 'sent_state_translatable'
  # it_behaves_like 'readable_state'
  # it_behaves_like 'simple_state_workflow'
  # it_behaves_like 'document_editable'
  it_behaves_like 'document_approvable'

end
