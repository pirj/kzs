# coding: utf-8
require 'acceptance/acceptance_helper'

feature "Approver ability sign order", %q() do
  let(:accountable) { FactoryGirl.create(:mail_with_direct_recipient_and_conformers) }
  let(:approver) { accountable.approver }
  # let(:recipient_user) { accountable.recipient_organization.admin }
  # let(:sender_user) { accountable.sender_organization.admin }
  let(:path) {  polymorphic_path(accountable) }

  subject { page }

  describe 'displaying approve btn' do
    context 'accountable have no confirm votes' do

      background do
        visit path
        sign_in_with user.email, 'password'
      end

      context 'creator' do
        let(:user) { accountable.creator }
        it { should_not have_content 'Подписать' }
      end

      context 'approver' do
        let(:user) { accountable.approver }
        it { should_not have_content 'Подписать' }
      end

    end
    context 'accountable have confirm votes' do
      background do
        accountable.conformers.each do |conformer|
          conformer.conform accountable.document
        end
        accountable.transition_to! :prepared

        visit path
        sign_in_with user.email, 'password'
      end

      context 'creator' do
        let(:user) { accountable.creator }
        it { should_not have_content 'Подписать' }
      end

      context 'approver' do
        let(:user) { accountable.creator }

        it { should have_content 'Подписать' }
      end
    end
    context 'deny' do
      background do

        _one = accountable.conformers.first
        _others = accountable.conformers - [_one]

        _others.each do |conformer|
          conformer.conform accountable.document
        end

        _one.deny accountable.document, 'test deny conformation'

        accountable.transition_to! :prepared
        visit path
        sign_in_with user.email, 'password'
      end

      context 'creator' do
        let(:user) { accountable.creator }
        it { should_not have_content 'Подписать' }
      end

      context 'approver' do
        let(:user) { accountable.approver }
        it { should_not have_content 'Подписать' }
      end

    end
  end
end
