require 'spec_helper'
require 'cancan/matchers'

describe User do

  context 'Ability for' do
    context 'Document' do
      let(:user) { nil }
      subject { Ability.new(user)}
      context 'outgoing' do
        context 'non-confidential' do
          let(:document) do
            FactoryGirl.create(:mail, confidential: false).document
          end

          context 'Saboteur' do
            let(:user) { FactoryGirl.create(:user) }
            it { should_not be_able_to(:read, document)}
          end

          context 'Employee' do
            let(:user) { FactoryGirl.create(:user) }

            before do
              document.sender_organization.users<<user
            end

            context 'draft' do

              context 'not author' do
                it { should_not be_able_to(:read, document)}
              end

              context 'is author' do
                before do
                  document.creator = user
                  document.save
                end

                it { should be_able_to(:read, document)}
              end
            end

            context 'prepared' do
              let(:document) do
                document = FactoryGirl.create(:mail, confidential: false).document
                document.creator = FactoryGirl.create(:user, organization_id: document.sender_organization_id)
                document.executor = FactoryGirl.create(:user, organization_id: document.sender_organization_id)
                document.approver = FactoryGirl.create(:user, organization_id: document.sender_organization_id)
                document.save
                document
              end

              before do
                accountable = document.accountable
                accountable.transition_to!(:prepared)
                document.reload
              end

              context 'Creator' do
                let(:user) { document.creator }

                it { should be_able_to(:read, document)}
                it { should be_able_to(:update, document)}
              end

              context 'Approver' do
                let(:user) { document.approver }

                it { should be_able_to(:read, document)}
                it { should be_able_to(:update, document)}
              end

              context 'Executor' do
                let(:user) { document.executor }

                it { should be_able_to(:read, document)}
                it { should be_able_to(:update, document)}
              end

              context 'Conformer' do
                let(:user){ FactoryGirl.create(:user) }
                before { document.conformers << user }

                it { should be_able_to(:read, document)}
                it { should_not be_able_to(:update, document)}
              end

              context 'Director' do
                let(:user) { document.sender_organization.director }

                it { should be_able_to(:read, document)}
              end

              context 'others' do
                it { should_not be_able_to(:read, document)}
                it { should_not be_able_to(:update, document)}
              end

            end

            context 'approved' do
              before do
                accountable = document.accountable
                accountable.transition_to!(:prepared)
                accountable.transition_to!(:approved)
                document.reload
              end

              it { should be_able_to(:read, document) }

              it { should_not be_able_to(:apply_sent, document.accountable) }

              context 'Approver' do
                let(:user) { document.approver }

                it { should be_able_to(:apply_sent, document.accountable)}
              end

            end
          end
        end

        context 'confidential' do
          let(:document) do
            document = FactoryGirl.create(:mail, confidential: true).document
            document.creator = FactoryGirl.create(:user, organization_id: document.sender_organization_id)
            document.executor = FactoryGirl.create(:user, organization_id: document.sender_organization_id)
            document.approver = FactoryGirl.create(:user, organization_id: document.sender_organization_id)
            document.save
            document
          end

          context 'Director' do
            let(:user){ document.sender_organization.director }

            it { should be_able_to(:read, document)}
          end

          context 'Creator' do
            let(:user){ document.creator }

            it { should be_able_to(:read, document)}
            it { should be_able_to(:update, document)}
          end

          context 'Executor' do
            let(:user){ document.executor }

            it { should be_able_to(:read, document)}
            it { should be_able_to(:update, document)}
          end

          context 'Approver' do
            let(:user){ document.approver }

            it { should be_able_to(:read, document)}
            it { should be_able_to(:edit, document)}
          end

          context 'Conformer' do
            let(:user){ FactoryGirl.create(:user) }

            before { document.conformers << user }

            it { should be_able_to(:read, document)}
            it { should_not be_able_to(:update, document)}
          end

          context 'Saboteur' do
            let(:user){ FactoryGirl.create(:user) }

            before { document.sender_organization.users << user }

            it { should_not be_able_to(:read, document)}
            it { should_not be_able_to(:update, document)}
          end
        end
      end
      context 'Incoming' do
        context 'non-confidential' do
          let(:document) do
            FactoryGirl.create(:mail, confidential: false).document
          end

          context 'Saboteur' do
            let(:user) { FactoryGirl.create(:user) }
            it { should_not be_able_to(:read, document)}
          end

          context 'Employee' do
            let(:user) { FactoryGirl.create(:user) }

            before do
              document.recipient_organization.users<<user
            end

            context 'draft' do
              it { should_not be_able_to(:read, document)}
            end

            context 'prepared' do
              before do
                document.accountable.transition_to!('prepared')
                document.reload
              end

              it { should_not be_able_to(:read, document) }

            end

            context 'approved' do
              before do
                document.accountable.transition_to!('prepared')
                document.accountable.transition_to!('approved')
                document.reload
              end

              it { should_not be_able_to(:read, document) }
            end

            context 'sent' do
              let(:document) do
                FactoryGirl.create(:mail, confidential: false).document
              end

              before do
                accountable = document.accountable
                accountable.transition_to!(:prepared)
                accountable.transition_to!(:approved)
                accountable.transition_to!(:sent)
                document.reload
              end

              it { should be_able_to(:read, document)}

            end
          end
        end

        context 'confidential' do
          let(:document) do
            FactoryGirl.create(:mail, confidential: true).document
          end

          before do
            accountable = document.accountable
            accountable.transition_to!(:prepared)
            accountable.transition_to!(:approved)
            accountable.transition_to!(:sent)
            document.reload
          end

          context 'Director' do
            let(:user){ document.recipient_organization.director }

            it { should be_able_to(:read, document)}
          end

          context 'Saboteur' do
            let(:user){ FactoryGirl.create(:user) }

            before { document.recipient_organization.users << user }

            it { should_not be_able_to(:read, document)}
          end
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
    let(:document) { FactoryGirl.create(:mail_with_direct_recipient_and_conformers).document }
    let(:conformer) {document.conformers.first}

    context "When in the conformers list" do
      it "should be able to conform document" do
        expect {conformer.conform(document)}.not_to raise_error
        expect(document.reload.conformed_users).to include conformer
      end  

      it "should be able to optionnaly add a comment when conforming" do
        expect {conformer.conform document, comment: 'Comment!'}.not_to raise_error
      end

      it "should be able to deny document" do
        expect {conformer.conform(document)}.not_to raise_error
        expect(document.reload.conformed_users).to include conformer
      end

      it "shouldn't be able to deny the document without a comment or with a nil/empty/space-only-characters comment" do
        expect {conformer.deny document}.to raise_error # Number of arguments 
        expect {conformer.deny document, nil}.to raise_error # Number of arguments 
        expect {conformer.deny document, ''}.to raise_error # Empty comment
        expect {conformer.deny document, '   '}.to raise_error # Considering comment empty
      end

      it "shouldn't be able to conform/deny a document if he already made a decision" do
        conformer.conform document
        expect { conformer.conform document }.to raise_error # Повторная попытка согласования
        expect { conformer.deny document, 'Comment!' }.to raise_error # Попытка изменить свое мнение
      end
    end

    context "When not in the conformers list" do
      it "shouldn't be able to conform document" do
        user = FactoryGirl.create(:user)

        expect {user.conform(document)}.to raise_error
      end

      it "shouldn't be able to deny document (with non-empty comment)" do
        user = FactoryGirl.create(:user)

        expect {user.deny(document, 'comment')}.to raise_error
      end
    end
  end
end
