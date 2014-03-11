require 'acceptance/acceptance_helper'

feature "Users edit and create an order", %q{} do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:order) { FactoryGirl.create(:order) }
  let(:path) { root_path }


  describe 'executer custom placeholder', js: true do
    let(:path) { new_documents_order_path }

    it 'should be render custom placeholder' do
      visit path
      sign_in_with user.email, 'password'

      within '.spec-order-field-show' do
        expect(page).to have_content 'Нажмите галку, чтобы выбрать'
      end
    end
  end

  describe 'form fill add fields and save' do
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


end