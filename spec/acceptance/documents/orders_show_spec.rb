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
          expect(page).to have_content 'черновик'
        end

        within '.spec-doc-action-buttons' do
          expect(page).to have_content 'редактировать'
        end

        # expect actions
        within '.spec-doc-action-buttons' do
          click_on 'редактировать'
        end

        expect(current_path).to eq edit_documents_order_path(order)
      end

      it 'should edit with prepared state' do
        order.transition_to!(:draft)
        order.transition_to!(:prepared)
        visit path

        # expect default conditions
        within '.spec-doc-state-field' do
          expect(page).to have_content 'подготовлено'
        end

        within '.spec-doc-action-buttons' do
          expect(page).to have_content 'редактировать'
        end

        # expect actions
        within '.spec-doc-action-buttons' do
          click_on 'редактировать'
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
          expect(page).to have_content 'подписан'
        end

        within '.spec-doc-action-buttons' do
          expect(page).to_not have_content 'редактировать'
        end
      end
    end
  end



  describe 'form fill add fields and save order' do
    let(:path) { new_documents_order_path }
      background do
        visit path
        sign_in_with user.email, 'password'
          # fill auction fields
          fill_in 'дата исполнения', with: '01.02.14'
          fill_in 'Тема', with: 'тест'
          fill_in 'Текст', with: 'тестовый текст'
          select order.sender_organization.users.last, from: 'Контрольное лицо'
          select Organization.last, from: 'Организация-получатель'
      end

      scenario 'should create new one order' do
        expect { click_button 'Подготовить' }.to change(Documents::Order, :count).by(1)
        expect(page).to have_content 'не может быть пустым'
        expect(current_path).to_not eq(documents_documents_path)
      end

      scenario 'should not create new order' do
        expect { click_button 'Подготовить' }.to_not change(Documents::Order, :count)
        expect(current_path).to_not eq(documents_documents_path)
        expect(page).to have_content 'не может быть пустым'
        save_and_open_page
      end
  end

  describe 'executer custom placeholder', js: true do

    scenario 'should not be "read" when open regular user' do
      visit path
      sign_in_with sender_user.email, 'password'

      within '.spec-doc-state-field' do
        expect(page).to have_content 'отправлено'
      end
    end
  end


end