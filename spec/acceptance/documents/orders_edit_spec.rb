require 'acceptance/acceptance_helper'

feature "Users edit and create an order", %q{} do

  let!(:order) { FactoryGirl.create(:order) }
  let(:user) { FactoryGirl.create(:user) }
  let(:recipient_user) { order.recipient_organization.admin }
  let(:sender_user) { order.sender_organization.admin }
  let(:path) {  documents_order_path(order) }


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

  describe 'form fill add fields and save', js: true do
    let(:path) { new_documents_order_path }
      background do
        visit path
        sign_in_with user.email, 'password'

          # fill auction fields
          fill_in 'дата исполнения', with: DateTime.now + 5.days
          fill_in 'Тема', with: 'тест'
          fill_in 'Текст', with: 'тестовый текст'
      end

      scenario 'should create new one order' do
        # TODO-levtolstoi нужно отрефакторить метод выбора chosen, не нормально, что мы передаем label = БЛА-БЛА-БЛА
        select_from_chosen label = 'Контрольное лицо'
        select_from_chosen label = 'Организация-получатель'

        expect { click_button 'Подготовить' }.to change(Documents::Order, :count).by(1)
        expect(page).to_not have_content 'не может быть пустым'
        expect(current_path).to eq(documents_documents_path)
      end

      scenario 'should not create new order' do
        expect { click_button 'Подготовить' }.to_not change(Documents::Order, :count)
        expect(current_path).to_not eq(documents_documents_path)
        expect(page).to have_content 'не может быть пустым'
        #save_and_open_page
      end
    end
end