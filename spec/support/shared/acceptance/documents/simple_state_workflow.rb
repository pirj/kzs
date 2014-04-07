# стандартные действия над документом
# подходит для страницы просмотра документа.
shared_examples_for 'simple_state_workflow' do

  context 'show page' do
    describe 'translate possible action-states from work-flow', js: true do
      let(:sender_user) { document.approver }

      scenario 'should be authorized as approver' do
        expect(page).to have_content sender_user.first_name_with_last_name
      end

      context 'draft is current state' do
        scenario 'should have action-states on page' do
          expect(page).to have_content 'В черновики'
          expect(page).to have_content 'Подготовить'
          expect(page).to_not have_content 'Подписать'
        end

        scenario 'should have action-states in popup' do
          within '.spec-doc-state-field' do
            skip_welcome
            click_link 'Черновик'
            expect(page).to have_content 'Подготовить'
            expect(page).to have_content 'В черновики'
            expect(page).to_not have_content 'Подписать'
          end
        end
      end

      context 'prepared is current state' do
        background do
          document.transition_to!(:prepared)
          visit path
        end

        scenario 'should have action-states on page' do
          expect(page).to have_content 'В черновики'
          expect(page).to have_content 'Подготовить'
          expect(page).to have_content 'Подписать'
        end

        scenario 'should have action-states in popup' do
          within '.spec-doc-state-field' do
            click_link 'Подготовлен'
            expect(page).to have_content 'Подготовить'
            expect(page).to have_content 'В черновики'
            expect(page).to have_content 'Подписать'
          end
        end

      end

      context 'approved is current state' do
        background do
          document.transition_to!(:prepared)
          document.transition_to!(:approved)
          visit path
        end

        scenario 'should have "sent" state' do
          expect(page).to have_content 'Отправить'
        end
      end
    end
  end

end
