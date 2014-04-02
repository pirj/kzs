require 'spec_helper'
require 'cancan/matchers'

describe User do

  context 'abilities' do
    context 'documents' do
      let(:organization) { FactoryGirl.create(:organization)}
      let(:user) { nil }
      subject { Ability.new(user)}

      context 'not confidential document' do
        let(:user) { FactoryGirl.create(:user) }
        let(:document) do
          FactoryGirl.create(:mail_with_direct_recipient, confidential: false).document
        end

        it { should be_able_to(:read, document)}

      end

      context 'confidential document' do
        let(:document) do
          document = FactoryGirl.create(:mail_with_direct_recipient, confidential: true).document
          document.creator = FactoryGirl.create(:user)
          document.executor = FactoryGirl.create(:user)
          document.approver = FactoryGirl.create(:user)
          document.save
          document
        end
        context 'read by director' do
          let(:user){ organization.director }
          it { should be_able_to(:read, document)}
        end

        context 'read by creator' do
          let(:user){ document.creator }
          it { should be_able_to(:read, document)}
        end

        context 'read by approver' do
          let(:user){ document.approver }
          it { should be_able_to(:read, document)}
        end

        context 'read by conformer' do
          let(:user){ FactoryGirl.create(:user) }
          before do
            document.conformers << user
          end
          it { should be_able_to(:read, document)}
        end

        context 'read by side user' do
          let(:user){ FactoryGirl.create(:user) }
          it { should_not be_able_to(:read, document)}
        end


      end


    end
  end

  context '#director?' do
    let(:organization) { FactoryGirl.create(:organization) }
    let(:director) { organization.director }
    let(:employee) { organization.accountant }
    let(:somebody) { FactoryGirl.create(:user) }
    context('for director') do
      subject { director.director? }
      it { should be_true }
    end
    context 'for employee' do
      subject { employee.director? }
      it { should  be_false }
    end
    context 'for somebody' do
      subject { somebody.director? }
      it { should be_false }
    end
  end
end
