# coding: utf-8
require 'acceptance/acceptance_helper'

feature "Users review order", %q() do

  let!(:accountable) { FactoryGirl.create(:order) }
  let!(:document) { accountable.document }

  describe 'accepts order by income report' do
  end

  describe 'decline order by income report' do
  end

  describe 'translates special states from work-flow' do
    context 'sent is current state' do
      context 'tasks not completed' do
        context 'sender' do
          it 'should not have "create report"' do
          end
        end

        context 'recipient' do
          it 'should not have "create report"' do
          end
        end
      end

      context 'tasks completed' do
        context 'sender' do
          it 'should not have "create report"'
        end

        context 'recipient' do
          it 'should have "create report"'
        end
      end

    end
  end

end