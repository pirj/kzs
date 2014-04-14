# coding: utf-8
require 'acceptance/acceptance_helper'

feature 'Approver can to approve order before sent', %q() do
  let!(:accountable) { FactoryGirl.create(:mail_with_direct_recipient_and_conformers) }
  let(:document) { accountable.document }
  let(:show_path) {  polymorphic_path(accountable) }

  subject { page }

  describe 'displaying approve action' do
    context 'document have no confirm votes' do

      background do
        visit show_path
        sign_in_with user.email
      end

      [:creator, :approver].each do |_user|
        context _user do
          let(:user) { document.send(_user) }
          it { should_not have_content 'Подписать' }
        end
      end

    end


    context 'document have all agree conform votes' do
      background do
        accountable.transition_to! :prepared
        document.conformers.each do |conformer|
          conformer.conform document
        end

        visit show_path
        sign_in_with user.email
      end

      context 'creator' do
        let(:user) { document.creator }
        it { should_not have_content 'Подписать'  }
      end

      context 'approver' do
        let(:user) { document.approver }
        it { should have_selector('a', text: 'Подписать') }
      end
    end


    context 'document have one deny conformations' do
      background do
        _one = document.conformers.first
        _others = document.conformers - [_one]

        _others.each do |conformer|
          conformer.conform document
        end
        _one.deny document, 'test deny conformation'

        accountable.transition_to! :prepared
        visit show_path
        sign_in_with user.email, 'password'
      end

      [:creator, :approver].each do |_user|
        context _user do
          let(:user) { document.send(_user) }
          it { should_not have_content 'Подписать' }
        end
      end

    end
  end
end
