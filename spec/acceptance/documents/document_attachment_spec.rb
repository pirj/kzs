require 'acceptance/acceptance_helper'

feature "Users attach existed documents to creating document", %q{} do

  let!(:documents) do
    5.times.map do |i|
      FactoryGirl.create(:order)
    end
  end

  let(:order) { FactoryGirl.create(:order_with_attachments) }
  let(:path) { new_documents_order_path }
  let(:user) { order.sender_organization.admin }

  describe 'Show attached documents in document edit-form' do
    context 'existed order with attachments' do
      let(:attached_count) { order.attached_documents.count }
      let(:path) { edit_documents_order_path(order) }

      background do
        visit path
        sign_in_with user.email, 'password'
      end

      scenario 'should render attached documents' do
        expect(page).to have_content 'Прикрепленные материалы'
        expect(page).to have_content 'Добавить документ'
        expect(page).to have_content "Документы (#{attached_count})"

        order.attached_documents.each do |attach|
          within '.spec-attached-documents' do
            expect(page).to have_content attach.title
          end
        end
      end
      describe 'allow remove attached documents' do
        context 'with saving form' do
          scenario 'should clear removed documents' do
            within '.spec-attached-documents' do
              expect { first('a', text: 'убрать').click }.to change(find('убрать'), :count).by(1)
            end

            expect { click_on 'Подготовить' }.to change(order.attached_documents, :count).by(1)
          end
        end
        context 'without saving form' do
          scenario 'should not clear removed documents' do
            within '.spec-attached-documents' do
              expect { first('a', text: 'убрать').click }.to change(find('убрать'), :count).by(1)
            end

            expect { click_on 'Отменить' }.to_not change(order.attached_documents, :count)
          end
        end
      end
    end
  end

  describe 'Single page for attaching documents' do
    scenario 'Open single page from edit-form' do
      visit path
      sign_in_with user.email, 'password'

      click_on 'Прикрепить документ'
    end

    describe 'Show attached documents' do
      describe 'Show documents list'
      describe 'Remove attached documents'
    end

    describe 'Attach some new documents' do

    end

    describe 'Save attached documents' do
    end

    describe 'Return to edit-form without saving attached documents' do

    end
  end

end