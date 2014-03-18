require 'spec/acceptance/acceptance_helper'

feature "Users view states for Order", %q{} do
  let(:document) { FactoryGirl.create(:order) }
  let(:user) { FactoryGirl.create(:user) }
  let(:recipient_user) { document.recipient_organization.admin }
  let(:sender_user) { document.sender_organization.admin }
  let(:path) {  documents_order_path(document) }

  background do
    visit path
    sign_in_with sender_user.email, 'password'
  end

  it_behaves_like 'sent_state_translatable'
  it_behaves_like 'readable_state'
  it_behaves_like 'simple_state_workflow'

  context 'show page' do
    describe 'translates special states from work-flow' do
      context 'sent is current state' do
        context 'tasks not completed' do
          context 'sender' do
            it 'should not have "create report"' do
            end
          end

          context 'recipient' do
            it 'should not have "create report"' do
            end
          end
        end

        context 'tasks completed' do
          context 'sender' do
            it 'should not have "create report"'
          end

          context 'recipient' do
            it 'should have "create report"'
          end
        end

      end
    end
  end
end