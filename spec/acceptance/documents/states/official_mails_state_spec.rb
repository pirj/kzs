require 'acceptance/acceptance_helper'

feature "Users view states for Official Mail", %q() do
  let!(:document) { FactoryGirl.create(:mail_with_many_recipients) }
  let(:user) { FactoryGirl.create(:user) }
  let(:recipient_user) { document.recipient_organization.admin }
  let(:sender_user) { document.sender_organization.admin }
  let(:path) {  documents_official_mail_path(document) }

  background do
    visit path
    sign_in_with sender_user.email, 'password'
  end

  it_behaves_like 'sent_state_translatable'
  it_behaves_like 'readable_state'
  it_behaves_like 'simple_state_workflow'
  it_behaves_like 'document_editable'

end
