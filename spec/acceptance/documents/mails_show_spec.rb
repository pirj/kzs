# coding: utf-8

require 'acceptance/acceptance_helper'

feature "User review mail", %q() do

  let!(:mail) { FactoryGirl.create(:mail) }
  let(:sender_user) { mail.approver }
  let(:recipient_user) { FactoryGirl.create(:user, organization: mail.recipient_organization) }
  let(:admin) { mail.recipient_organization.admin }
  let(:director) { mail.recipient_organization.director }
  let(:show_path) {  documents_official_mail_path(mail) }

  describe 'reply action' do
    background do
      mail.transition_to!(:draft)
      mail.transition_to!(:prepared)
      mail.transition_to!(:approved)
      mail.transition_to!(:sent)
      visit show_path
    end

    context 'sender' do
      background do
        sign_in_with sender_user.email, 'password'
        expect(current_path).to eq(show_path)
      end

      scenario 'not check reply action' do
        expect(page).to_not have_content('Ответить')
      end
    end

    context 'recipient' do
      background do
        sign_in_with user.email, 'password'
        expect(current_path).to eq(show_path)
      end

      [:recipient_user, :admin, :director].each do |_user|
        context _user do
          let(:user) { send(_user) }

          context 'ajax', js: true  do
            background do
              skip_welcome
              click_on 'Ответить'
              expect(current_path).to match('reply')
            end

            context 'fill valid mail attributes' do
              scenario 'create reply mail' do
                _title = 'Тема ответного письма'

                select_from_chosen 'Контрольное лицо'
                fill_in 'Тема', with: _title
                fill_in 'Текст', with: 'Текст ответного письма'

                expect { click_on 'Подготовить' }.to change(Documents::OfficialMail, :count).by(1)
                expect(page).to have_content 'Документ успешно создан'
                expect(current_path).to eq documents_path
                expect(page).to have_content _title
              end

            end

            context 'fill invalid mail attributes' do
              scenario 'displaying errors' do
                select_from_chosen 'Контрольное лицо'

                expect { click_on 'Подготовить' }.to_not change(Documents::OfficialMail, :count)
                expect(page).to_not have_content 'Документ успешно создан'
                expect(page).to have_content 'не может быть пустым'
              end
            end

          end
        end
      end

    end
  end
end
