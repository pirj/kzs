require 'spec/acceptance/acceptance_helper'

feature "Users view states for Report", %q{} do
  let(:document) { FactoryGirl.create(:report) }
  let(:user) { FactoryGirl.create(:user) }
  let(:recipient_user) { document.recipient_organization.admin }
  let(:sender_user) { document.sender_organization.admin }
  let(:path) {  documents_report_path(document) }

  background do
    visit path
    sign_in_with sender_user.email, 'password'
  end

  it_behaves_like 'sent_state_translatable'
  it_behaves_like 'readable_state'
  it_behaves_like 'simple_state_workflow'

end