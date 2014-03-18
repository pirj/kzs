# coding: utf-8
require 'acceptance/acceptance_helper'

feature "Users review order", %q{} do

  let!(:order) { FactoryGirl.create(:order) }
  let(:user) { FactoryGirl.create(:user) }
  let(:recipient_user) { order.recipient_organization.admin }
  let(:sender_user) { order.sender_organization.admin }
  let(:path) {  documents_order_path(order) }

  background do
    visit root_path
    sign_in_with sender_user.email, 'password'
  end

  describe 'edit existed order' do
    context 'sender' do
      it 'should edit with draft state' do
        order.transition_to!(:draft)
        visit path

        # expect default conditions
        within '.spec-doc-state-field' do
          expect(page).to have_content 'Черновик'
        end

        within '.spec-doc-action-buttons' do
          expect(page).to have_content 'Редактировать'
        end

        # expect actions
        within '.spec-doc-action-buttons' do
          click_on 'Редактировать'
        end

        expect(current_path).to eq edit_documents_order_path(order)
      end

      it 'should edit with prepared state' do
        order.transition_to!(:draft)
        order.transition_to!(:prepared)
        visit path

        # expect default conditions
        within '.spec-doc-state-field' do
          expect(page).to have_content 'Подготовлено'
        end

        within '.spec-doc-action-buttons' do
          expect(page).to have_content 'Редактировать'
        end

        # expect actions
        within '.spec-doc-action-buttons' do
          click_on 'Редактировать'
        end

        expect(current_path).to eq edit_documents_order_path(order)
      end

      it 'should not edit with approved state' do
        order.transition_to!(:draft)
        order.transition_to!(:prepared)
        order.transition_to!(:approved)
        visit path

        # expect default conditions
        within '.spec-doc-state-field' do
          expect(page).to have_content 'Подписан'
        end

        within '.spec-doc-action-buttons' do
          expect(page).to_not have_content 'Редактировать'
        end
      end
    end
  end

end