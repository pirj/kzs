shared_examples_for 'simple_state_workflow' do

  context 'show page' do
    describe 'translate possible states from work-flow' do
      let(:sender_user) { document.approver }

      scenario 'should be authorized as approver' do
        expect(page).to have_content sender_user.first_name_with_last_name
      end

      context 'draft is current state' do
        scenario 'should have "draft" state' do
          expect(page).to have_content 'В черновики'
        end

        scenario 'should have "prepared" state' do
          expect(page).to have_content 'Подготовить'
        end
      end

      context 'prepared is current state' do
        background do
          document.transition_to!(:prepared)
          visit path
        end

        scenario 'should have "approved" state' do
          expect(page).to have_content 'Подписать'
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
