# coding: utf-8
require 'acceptance/acceptance_helper'

feature "Users review reports", %q() do

  let!(:accountable) { FactoryGirl.create(:report) }
  let!(:document) { accountable.document }
  let!(:order) { accountable.order }

  let(:show_path) { polymorphic_path(accountable) }

  let(:order_approver) { order.approver }
  let(:order_creator) { order.creator }
  let(:order_user) { FactoryGirl.create(:user, organization: order.sender_organization) }

  let(:report_approver) { document.approver }
  let(:report_user) { FactoryGirl.create(:user, organization: document.sender_organization) }

  background do
    visit show_path
    sign_in_with user.email
  end

  describe 'apply or deny income report' do
    context 'not sent' do
      context 'recipient organization' do
        [:order_user, :order_approver].each do |_user|
          context _user do
            let(:user) { send(_user) }
            scenario 'access denied' do
              expect(current_path).to_not eq show_path
              expect(page).to have_content 'Недостаточно прав'
            end
          end
        end
      end
    end

    context 'sent' do
      background do
        accountable.transition_to!(:prepared)
        accountable.transition_to!(:approved)
        accountable.transition_to!(:sent)
        visit show_path
        expect(current_path).to eq show_path
      end

      context 'recipient organization' do
        context 'order approver' do
          let(:user) { order_approver }
          scenario 'displaying two action button' do
            expect(page).to have_selector('a', text: 'Подписать')
            expect(page).to have_selector('a', text: 'Отклонить')
          end
        end

        [:order_user, :order_creator].each do |_user|
          context _user do
            let(:user) { send(_user) }
            scenario 'not displaying two action button' do
              expect(page).to_not have_selector('a', text: 'Подписать')
              expect(page).to_not have_selector('a', text: 'Отклонить')
            end
          end
        end

        scenario 'click "allow" button'
        scenario 'click "deny" button'
      end

      context 'sender organization' do
        [:report_approver, :report_user].each do |_user|
          context _user do
            let(:user) { send(_user) }
            scenario 'not displaying action buttons' do
              expect(page).to_not have_content 'Подписать'
              expect(page).to_not have_content 'Отклонить'
            end
          end
        end
      end
    end
  end

end