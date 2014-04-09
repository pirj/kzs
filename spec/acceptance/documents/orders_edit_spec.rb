require 'acceptance/acceptance_helper'

feature "Users edit and create an order", %q() do

  let!(:order) { FactoryGirl.create(:order) }
  let(:user) { FactoryGirl.create(:user) }
  let(:recipient_user) { order.recipient_organization.admin }
  let(:sender_user) { order.sender_organization.admin }
  let(:path) { documents_order_path(order) }

  pending 'executer custom placeholder', js: true do
    let(:path) { new_documents_order_path }

    pending 'should be render custom placeholder' do
      visit path
      sign_in_with user.email, 'password'

      within '.spec-order-field-show' do
        expect(page).to have_content 'Нажмите галку, чтобы выбрать'
      end
    end
  end

  pending 'form fill add fields and save', js: true do
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
        select_from_chosen 'Контрольное лицо'
        select_from_chosen 'Организация-получатель'
        skip_welcome
        expect { click_button 'Подготовить' }.to change(Documents::Order, :count).by(1)
        expect(page).to_not have_content 'не может быть пустым'
        expect(current_path).to eq(documents_path)
      end

      pending 'should not create new order' do
        expect { click_button 'Подготовить' }.to_not change(Documents::Order, :count)
        expect(current_path).to_not eq(documents_path)
        expect(page).to have_content 'не может быть пустым'
        # save_and_open_page
      end
  end

  describe 'document-saver should be saved like creator' do
    let(:old_creator) { order.creator }
    let(:new_creator) { order.sender_organization.director }

    let(:show_path) { documents_order_path(order) }
    let(:path) { edit_documents_order_path(order) }

    background do
      visit path
      sign_in_with user.email
    end

    context 'old creator sees document' do
      let(:user) { old_creator }
      let(:creator_name) { old_creator.first_name_with_last_name }
      scenario 'sees self name' do
        visit show_path
        within('.spec-document-creator') do
          expect(page).to have_content creator_name
        end
      end
    end

    context 'new editor save document' do
      let(:user) { new_creator }
      let(:creator_name) { new_creator.first_name_with_last_name }

      background do
        # сохраняем нового псевдоюзера под контрольным лицом в документе,чтобы у нас были права просмотра документа из под него
        expect(new_creator).to_not eq old_creator
        order.approver = new_creator
        order.save!
        visit path
      end

      scenario 'update old creator to new creator' do
        within('.spec-document-creator') do
          expect(page).to have_content creator_name
        end

        click_on 'Подготовить'
        visit show_path

        within('.spec-document-creator') do
          expect(page).to have_content creator_name
        end
      end
    end

  end
end
