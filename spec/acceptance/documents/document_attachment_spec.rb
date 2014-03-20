# coding: utf-8
require 'acceptance/acceptance_helper'

feature "Users attach existed documents to creating document", %q{} do
  before { pending }

  let!(:documents) do
    5.times.map do |i|
      FactoryGirl.create(:mail_with_many_recipients)
    end
  end

  let!(:user) { document.sender_organization.admin }

  let(:document) { FactoryGirl.create(:mail_with_attached_documents) }
  let(:document_attachments) { document.attached_documents }
  let(:attached_count) { document_attachments.count }

  let(:new_path) { new_documents_official_mail_path }
  let(:edit_path) { edit_documents_official_mail_path(document) }

  background do
    visit new_path
    sign_in_with user.email, 'password'
  end

  describe 'Show attached documents in document edit-form' do
    context 'existed document with attachments' do
      background{ visit edit_path }

      scenario 'should render attached documents' do
        expect(page).to have_content 'Прикрепленные материалы'
        expect(page).to have_content 'Добавить документ'
        expect(page).to have_content "Документы (#{attached_count})"

        document.attached_documents.each do |attach|
          within '.spec-attached-documents' do
            expect(page).to have_content attach.title
          end
        end
      end
      describe 'allow remove attached documents', js: true do
        background do
          within '.spec-attached-documents' do
            expect { first('a', text: 'убрать').click }.to_not change(all('a', text: 'убрать'), :count)
            expect(first('a', text: 'убрать')).to_not be_visible
          end
        end

        context 'with saving form' do
          scenario 'should clear removed documents' do
            expect { click_on 'подготовить' }.to change(document_attachments, :count).by(-1)
          end
        end
        context 'without saving form' do
          scenario 'should not clear removed documents' do
            expect { click_on 'Отменить' }.to_not change(document_attachments, :count)
          end
        end
      end
    end
  end

  describe 'Single page for attaching documents' do
    let(:attach_path) { 'attach_documents_document_path(document)' }

    scenario 'Open single page from edit-form' do
      visit edit_path
      click_on 'Прикрепить документ'
      expect(current_page).to eq path
    end

    describe 'Show previosly attached documents' do

      it 'should render attached documents' do
        within '.spec-attached-documents' do
          document_attachments.each do |doc|
            expect(page).to have_content doc.title
            expect(page).to have_content 'убрать'
          end
        end
      end

      describe 'allow to remove attached documents' do
        context 'without submit' do
          it 'should hide in view' do
            expect { first('a', text: 'убрать').click }.to change(find('убрать'), :count).by(1)
          end

          it 'should not delete in db' do
            old_count = all('убрать').count
            first('a', text: 'убрать').click
            visit path
            expect(find('убрать').count).to eq old_count
          end
        end

        context 'with submit' do
          it 'should remove hidden documents' do
            within '.spec-attached-documents' do
              old_count = find('убрать').count
              first('a', text: 'убрать')
              click_on 'Готово'
              expect(find('убрать').count).to eq(old_count - 1)
            end
          end
        end
      end
    end

    describe 'Attach some new documents' do
      it 'should attach document to attached document list' do
        first('.spec-attach-doc').click
        expect(current_path).to eq attach_path
        within '.spec-attached-documents' do
          expect(find('убрать').count).to eq(attached_count + 1)
        end
      end

      it 'should not attach added documents' do
        first('.spec-attach-doc').click
        first('.spec-attach-doc').click
        within '.spec-documents-list' do
          expect(page.has_css?('.spec-attached-document')).to be_true
          expect(find('.spec-attached-document').count).to eq 2
        end
      end
    end

    describe 'Return to edit-form with submit attached documents' do
      it 'show all attached documents' do
        visit attach_path

        first('.spec-attach-doc').click
        first('.spec-attach-doc').click

        click_on 'Готово'

        within '.spec-attached-documents' do
          expect(page.find('убрать').count).to eq(attached_count + 2)
        end
      end
    end

    describe 'Return to edit-form without saving attached documents' do
      background { visit attach_path }

      it 'return to form' do
        click_on 'отмена'
        expect(current_path).to eq edit_path
      end

      it 'not change attached documents' do
        first('.spec-attach-doc').click
        first('.spec-attach-doc').click
        click_on 'отмена'

        within '.spec-attached-documents' do
          expect(find('убрать').count).to eq attached_count
        end
      end
    end
  end

end