# coding: utf-8
require 'acceptance/acceptance_helper'

feature "Users can conform or deny document", %q{} do


  describe 'displaying conformations in document show-page' do

    subject { page }

    let!(:accountable) do
      a = FactoryGirl.create(:mail_with_direct_recipient_and_conformers)
      a.transition_to!(:prepared)
      a
    end
    let!(:document) do
      doc = accountable.document
      doc.conformers.each do |_conformer|
        _conformer.conform doc, comment: 'testing conformation comment'
      end

      doc.conformations.reload
      doc
    end
    let(:show_path) { polymorphic_path(accountable) }

    let(:conformers) { document.conformers }

    let(:conformer) { document.conformers.first }
    let(:approver) { document.approver }
    let(:sender_user) { FactoryGirl.create(:user, organization: document.sender_organization) }
    let(:recipient_organization) { document.recipient_organization.director }

    background do
      accountable.transition_to!(:approved)
      accountable.transition_to!(:sent)
      expect(document.conformations).to_not be_empty
      visit show_path
      sign_in_with user.email
    end

    context 'displaying conformations' do
      [:conformer, :approver, :sender_user].each do |user_role|
        context user_role do
          let(:user) { send(user_role.to_sym) }

          it { should have_content 'Согласование' }
          it { should have_content "Комментарии (#{conformers.count})" }

          scenario 'displaying conformers name' do
            conformers.each do |_conformer|
              expect(page).to have_content _conformer.first_name_with_last_name
            end
          end

          scenario 'displaying conformers comments' do
            expect(document.conformations).to_not be_empty
            document.conformations.each do |_conform|
              expect(page).to have_content _conform.comment
            end
          end
        end
      end
    end

    context 'hidding conformations' do
      context 'recipient organization' do
        let(:user) { document.recipient_organization.director }
        it { should_not have_content 'Согласование' }
        it { should_not have_content "Комментарии (#{conformers.count})" }

        scenario 'hidding conformation comments' do
          expect(document.conformations).to_not be_empty
          document.conformations.each do |_conform|
            expect(page).to_not have_content _conform.comment
          end
        end

        scenario 'hidding conformers name' do
          expect(conformers).to_not be_empty
          conformers.each do |_conformer|
            expect(page).to_not have_content _conformer.first_name_with_last_name
          end
        end
      end
    end

  end

end