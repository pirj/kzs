require 'acceptance/acceptance_helper'

feature "Users review order", %q{} do

  let(:user) { FactoryGirl.create(:user) }
  let(:recipient_user) { order.recipient_organization.admin }
  let(:sender_user) { order.sender_organization.admin }
  let!(:order) { FactoryGirl.create(:order) }


  background do
    visit root_path
    sign_in_with sender_user.email, 'password'
  end

  describe 'edit existed order' do
    context 'sender' do
      it 'should edit with draft state' do
        order.transition_to!(:draft)
        visit documents_order_path(order)

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
        visit documents_order_path(order)

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
        visit documents_order_path(order)

        # expect default conditions
        within '.spec-doc-state-field' do
          expect(page).to have_content 'подписан'
        end

        within '.spec-doc-action-buttons' do
          expect(page).to_not have_content 'редактировать'
        end
      end
    end

    context 'recipient' do
      pending 'should not review a order'
    end
  end

  #describe 'executer custom placeholder', js: true do
  #  let(:path) { new_documents_order_path }
  #
  #  it 'should be render custom placeholder' do
  #    visit path
  #    sign_in_with user.email, 'password'
  #
  #    within '.spec-order-field-show' do
  #      expect(page).to have_content 'Нажмите галку, чтобы выбрать'
  #    end
  #  end
  #end

  describe 'special tranlsates for sent states for recipient and sender' do

    let(:path) { documents_order_path(order) }
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
        page.driver.submit :delete, destroy_user_session_path, {}
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

end