# coding: utf-8

require 'acceptance/acceptance_helper'

feature "User receives documents notifications", %q() do

  let!(:mail) { FactoryGirl.create(:prepared_mail) }


  describe 'notifiable list' do

    let(:unreadable_path) { documents_path(with_type: 'unread') }

    background do
      visit unreadable_path
      sign_in_with user.email
      visit unreadable_path
      expect(current_url).to eq  documents_url(with_type: 'unread')
    end

    context 'without notifiable documents' do
      let(:user){ mail.sender_organization.director }
      context 'another user' do
        scenario 'empty document list' do
          expect(page).to have_content 'по заданным параметрам фильтрации документов нет'
        end
      end
    end

    context 'with notifiable documents' do
      let!(:mail) { FactoryGirl.create(:mail_with_direct_recipient_and_conformers) }

      let(:edit_path) { edit_polymorphic_path(mail) }

      let(:approver) { mail.approver }
      let(:executor) { mail.executor }
      let(:conformer) { mail.conformers.first }

      [:executor].each do |_user|
        context _user do

          # оповещения создаются по-настоящему в контроллерах, никаких колбеков в моделях
          # поэтому нужно зайти под главным и протолкнуть письмо далее по цепочке статусов
          background do
            sign_out
            visit edit_path
            sign_in_with approver.email
            expect(current_path).to eq edit_path
            click_on 'Сохранить'

            sign_out
            sign_in_with user.email
            visit unreadable_path
          end

          let(:user) { send(_user) }

          scenario 'not empty document list' do
            save_and_open_page
            expect(page).to_not have_content 'по заданным параметрам фильтрации документов нет'
          end

          scenario 'badge about notifiable documents count'
        end
      end

    end
  end

  describe 'show notifications about notifiable documents' do
    context 'unchanged documents' do
      scenario 'not sees notifications'
    end

    context 'prepared document' do

      context 'approver, executor, conformators' do
        scenario 'sees notification'
      end

      context 'director, another_user, recipient_user' do
        scenario 'not sees notification'
      end

      context 'open notifiable document' do
        context 'approver, executor, conformators' do
          scenario 'not sees notification for this document'

          context 'other user have read this document before' do
            scenario 'sees notification'
          end
        end
      end

    end

    context 'edited document' do
      context 'one who was expelled from interested people' do
        context 'old creator, old executor, old approver, old conformators' do
          scenario 'not sees notification'
        end
      end

      context 'current editor (new creator)' do
        scenario 'not sees notification'
      end

      context 'new creator, new executor, conformators' do
        scenario 'sees notification'
      end
    end

    context 'replied mail' do
      context 'interested people' do
        scenario 'sees notification'
      end
    end
  end

end
