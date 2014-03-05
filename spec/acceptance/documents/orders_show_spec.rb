require 'acceptance/acceptance_helper'

feature "Users review order", %q{} do

  let(:user) { FactoryGirl.create(:user) }
  let(:recipient_user) { order.recipient_organization.admin }
  let(:sender_user) { order.sender_organization.admin }
  let!(:order) { FactoryGirl.create(:order) }
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
    background do
      order.transition_to!(:draft)
      order.transition_to!(:prepared)
      order.transition_to!(:approved)
      order.transition_to!(:sent)

      sign_out
    end
    context 'recipient director has not yet open document' do
      context 'recipient organization' do
        let(:recipient_user) { order.recipient_organization.accountant }
        let(:recipient_director) { order.recipient_organization.director }


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
          end
        end
      end

      context 'sender organization' do
        let(:sender_user) { order.sender_organization.accountant }

        scenario 'should not be "read" when open regular user' do
          visit path
          sign_in_with sender_user.email, 'password'

          within '.spec-doc-state-field' do
            expect(page).to have_content 'отправлено'
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
            expect(page).to have_content 'получено'
          end
        end
      end

      context 'sender organization users' do
        it 'should be "read" status for all users' do
          visit path
          sign_in_with sender_user.email, 'password'

          within '.spec-doc-state-field' do
            expect(page).to have_content 'получено'
          end
        end
      end
    end
  end





end