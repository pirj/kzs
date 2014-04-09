require 'acceptance/acceptance_helper'

feature "Users edit and create an order", %q() do

  let!(:order) { FactoryGirl.create(:order) }
  let(:user) { FactoryGirl.create(:user) }
  let(:recipient_user) { order.recipient_organization.admin }
  let(:sender_user) { order.sender_organization.admin }
  let(:show_path) { documents_order_path(order) }
  let(:new_path) { new_documents_order_path }
  let(:edit_path) { edit_documents_order_path(order) }


  pending 'form fill fields and save', js: true do
      background do
        visit new_path
        sign_in_with user.email
        skip_welcome

          # fill auction fields
        fill_in 'дата исполнения', with: DateTime.now + 5.days
        fill_in 'Тема', with: 'тест'
        fill_in 'Текст', with: 'тестовый текст'
      end

      context 'success create new one order' do
        background do
          select_from_chosen 'Контрольное лицо'
          select_from_chosen 'Организация-получатель'
          within('.spec-document-creator') do
            expect(page).to have_content user.first_name_with_last_name
          end
          expect { click_button 'Подготовить' }.to change(Documents::Order, :count).by(1)
          expect(page).to_not have_content 'не может быть пустым'
        end

        scenario 'redirect to documents list' do
          expect(current_path).to eq(documents_path)
        end

        scenario 'current user sees self name as creator' do
          # берем последний документ, потому что при успешном создании,документ ложится в конец таблицы
          order = Documents::Order.last
          visit documents_order_path(order)

          within('.spec-document-creator') do
            expect(page).to have_content user.first_name_with_last_name
          end
        end
      end

      pending 'should not create new order' do
        expect { click_button 'Подготовить' }.to_not change(Documents::Order, :count)
        expect(current_path).to_not eq(documents_path)
        expect(page).to have_content 'не может быть пустым'
        # save_and_open_page
      end

  end

  describe 'document-saver should be saved like creator for existed document' do
    let(:old_creator) { order.creator }
    let(:new_creator) { order.sender_organization.director }

    background do
      visit edit_path
      sign_in_with user.email
    end

    context 'old creator sees existed document' do
      let(:user) { old_creator }
      let(:creator_name) { user.first_name_with_last_name }
      scenario 'sees self name' do
        visit show_path
        within('.spec-document-creator') do
          expect(page).to have_content creator_name
        end
      end
    end

    context 'new editor save existed document' do
      let(:user) { new_creator }
      let(:creator_name) { user.first_name_with_last_name }

      background do
        # сохраняем нового псевдоюзера под контрольным лицом в документе,чтобы у нас были права просмотра документа из под него
        expect(user).to_not eq old_creator
        order.approver = new_creator
        order.save!
        visit edit_path
      end

      scenario 'update old creator to new creator' do
        within('.spec-document-creator') do
          expect(page).to have_content creator_name
        end
        click_on 'Подготовить'
        expect(current_path).to eq documents_path
        visit show_path
        within('.spec-document-creator') do
          expect(page).to have_content creator_name
        end
      end
    end

  end
end
