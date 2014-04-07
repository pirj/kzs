require 'spec_helper'
require 'cancan/matchers'

describe User do

  context 'abilities' do
    context 'documents' do
      let(:organization) { FactoryGirl.create(:organization)}
      let(:user) { nil }
      subject { Ability.new(user)}

      context 'non-confidential' do
        let(:document) do
          FactoryGirl.create(:mail_with_direct_recipient, confidential: false).document
        end
        context 'Employee' do
          let(:user) { FactoryGirl.create(:user) }

          before do
            document.sender_organization.users<<user
          end

          it { should be_able_to(:read, document)}
        end

        context 'Saboteur' do
          let(:user) { FactoryGirl.create(:user) }

          it { should_not be_able_to(:read, document)}
        end

      end

      context 'confidential document' do
        let(:document) do
          document = FactoryGirl.create(:mail_with_direct_recipient, confidential: true).document
          document.creator = FactoryGirl.create(:user, organization_id: document.sender_organization_id)
          document.executor = FactoryGirl.create(:user, organization_id: document.sender_organization_id)
          document.approver = FactoryGirl.create(:user, organization_id: document.sender_organization_id)
          document.save
          document
        end
        context 'Director' do
          let(:user){ organization.director }
          it { should be_able_to(:read, document)}
        end

        context 'Creator' do
          let(:user){ document.creator }
          it { should be_able_to(:read, document)}
        end

        context 'Approver' do
          let(:user){ document.approver }
          it { should be_able_to(:read, document)}
        end

        context 'Conformer' do
          let(:user){ FactoryGirl.create(:user) }
          before do
            document.conformers << user
          end
          it { should be_able_to(:read, document)}
        end

        context 'Saboteur' do
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

  context 'conforming documents' do
    before :each do
      @mail_to_conform = FactoryGirl.create(:mail_with_direct_recipient_and_conformers)
      @conformer = mail_to_conform.conformers.first
    end

    context "When in the conformers list" do
      it "should be able to conform document" do
        expect {@conformer.conform(@mail_to_conform)}.not_to raise_error
        @mail_to_conform.conformed_users.should include @conformer
      end  

      it "should be able to optionnaly add a comment when conforming" do
        @conformer.conform @mail_to_conform, comment: "Comment!"

        expect {@conformer.conform @mail_to_conform}.not_to raise_error
      end

      it "should be able to deny document" do
        expect {@conformer.conform(@mail_to_conform)}.not_to raise_error
        @mail_to_conform.conformed_users.should include @conformer
      end

      it "shouldn't be able to deny the document without a comment or with a nil/empty/space-only-characters comment" do
        expect {@conformer.deny @mail_to_conform}.to raise_error # Number of arguments 
        expect {@conformer.deny @mail_to_conform, nil}.to raise_error # Number of arguments 
        expect {@conformer.deny @mail_to_conform, ''}.to raise_error # Empty comment
        expect {@conformer.deny @mail_to_conform, '   '}.to raise_error # Considering comment empty
      end

      it "shouldn't be able to conform/deny a document if he already made a decision" do
        @conformer.conform @mail_to_conform
        expect { @conformer.conform @mail_to_conform }.to raise_error # Повторная попытка согласования
        expect { @conformer.deny @mail_to_conform, 'Comment!' }.to raise_error # Попытка изменить свое мнение
      end
    end

    context "When not in the conformers list" do
      it "shouldn't be able to conform document, if it's not in the conformers list" do
        user = FactoryGirl.create(:user)

        expect {user.conform(@mail_to_conform)}.to raise_error
        @mail_to_conform.conformed_users.should_not include user
      end

      it "shouldn't be able to deny document (with non-empty comment), if it's not in the conformers list" do
        user = FactoryGirl.create(:user)

        expect {user.conform(@mail_to_conform)}.to raise_error
        @mail_to_conform.conformed_users.should_not include user
      end
    end
  end
end
