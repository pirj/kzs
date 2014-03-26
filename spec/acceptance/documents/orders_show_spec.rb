# coding: utf-8
require 'acceptance/acceptance_helper'

feature "Users review order", %q() do

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

  describe 'correct user permissions' do
    context 'sender' do
      it 'must see tasks' do
        visit path
        within '.spec-doc-tasks' do
          expect(page).to have_content 'task title'
        end

      end

      it 'not allows to manage tasks', :js => true  do
        visit path
        i = all('.spec-task-checkbox.disabled').count
        expect(all('.spec-task-checkbox').count).to eq(i)
      end
    end

    context 'recipient' do
      it 'allows to manage tasks', :js => true  do
        sign_out_js
        sign_in_with recipient_user.email, 'password'
        visit path
        all('.iCheck-helper').each do |i|
          i.click
        end

        page.save_screenshot('/test_images/order.png', full: true)
        i = all('.spec-task-checkbox.disabled').count

        expect(all('.spec-task-checkbox').count).to_not eq(i)


      end

    end

  end

end