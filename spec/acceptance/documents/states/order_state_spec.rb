require 'spec/acceptance/acceptance_helper'

feature "Users view actions for order", %q{} do
  let!(:order) { FactoryGirl.create(:order) }
  let(:user) { FactoryGirl.create(:user) }
  let(:recipient_user) { order.recipient_organization.admin }
  let(:sender_user) { order.sender_organization.admin }
  let(:path) {  documents_order_path(order) }

  background do
    visit path
    sign_in_with sender_user.email, 'password'
  end

  describe 'special translates for sent states for recipient and sender' do

    background do
      order.transition_to!(:draft)
      order.transition_to!(:prepared)
      order.transition_to!(:approved)
      order.transition_to!(:sent)
    end

    it 'should not equals recipient-user and sender-user' do
      expect(sender_user).to_not eq recipient_user
    end

    context 'user from sender organization' do
      background do
        page.driver.submit :delete, destroy_user_session_path, {}
        visit path
        sign_in_with sender_user.email, 'password'
      end

      it 'should render sender-state name' do
        within '.spec-doc-state-field' do
          expect(page).to have_content 'отправлено'
        end
      end
    end

    context 'user from recipient organization' do
      background do
        sign_out
        visit path
        sign_in_with recipient_user.email, 'password'
      end

      it 'should render recipient-state name' do
        within '.spec-doc-state-field' do
          expect(page).to have_content 'получено'
        end
      end
    end
  end

  describe '"read" status after recipient director open a document' do
    let(:recipient_user) { order.recipient_organization.accountant }
    let(:recipient_director) { order.recipient_organization.director }
    background do
      sign_out
      order.transition_to!(:draft)
      order.transition_to!(:prepared)
      order.transition_to!(:approved)
      order.transition_to!(:sent)
    end

    context 'recipient director has not yet open document' do
      context 'recipient organization' do
        scenario 'should not be "read" when open regular user' do
          visit path
          sign_in_with recipient_user.email, 'password'

          within '.spec-doc-state-field' do
            expect(page).to have_content 'получено'
          end
        end

        scenario 'should be "read" when open director' do
          visit path
          sign_in_with recipient_director.email, 'password'
          within '.spec-doc-state-field' do
            expect(page).to have_content 'прочитано'
            #expect(page).to have_content "#{order.recipient_organization.inspect}"
          end
        end
      end
    end

    context 'recipient director opens a document' do
      let(:recipient_user) { order.recipient_organization.accountant }
      let(:recipient_director) { order.recipient_organization.director }
      let(:sender_user) { order.sender_organization.accountant }

      background do
        visit path
        sign_in_with recipient_director.email, 'password'
        sign_out
      end

      context 'recipient organization users' do
        it 'should be "read" status for all users' do
          visit path
          sign_in_with recipient_user.email, 'password'

          within '.spec-doc-state-field' do
            expect(page).to have_content 'прочитано'
          end
        end
      end

      context 'sender organization users' do
        it 'should be "read" status for all users' do
          visit path
          sign_in_with sender_user.email, 'password'

          within '.spec-doc-state-field' do
            expect(page).to have_content 'прочитано'
          end
        end
      end
    end
  end

  describe 'state translates flow for user' do
    context 'draft is current state' do
      it 'should have "prepared" state'
      it 'should have "draft" state'
    end

    context 'prepared is current state' do
      it 'should have "edit" state'
      it 'should have "approved" state'
    end

    context 'approved is current state' do
      it 'should have "sent" state'
    end

    context 'sent is current state' do
      context 'tasks not completed' do
        context 'sender' do
          it 'should not have "create report"'
        end

        context 'recipient' do
          it 'should not have "create report"'
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