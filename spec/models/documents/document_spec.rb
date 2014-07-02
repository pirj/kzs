require 'spec_helper'

describe Document do

  subject!(:document) { FactoryGirl.create(:approved_mail).document }
  it_behaves_like 'notifiable object'

  # context "when using notifications" do
  #   it 'can have only one notification per user' do
  #     unless subject.class.multiple_notifications
  #       expect {2.times {subject.notifications.create(user: user)}}.to change {subject.notifications.count}.from(0).to(1)
  #     end
  #   end
  # end

  context "when using notifications" do
    before :each do
      document.clear_notifications
    end
    it 'can have only one notification per user' do
      expect {2.times {document.notify_interesants(only: :executor)}}.to change{document.notifications.where(user_id: document.executor.id).count}.from(0).to(1)
    end
  end

  context 'when have conformations and being updated' do
    let(:mail) {FactoryGirl.create(:mail_with_direct_recipient_and_conformers)}
    let(:conformer) {mail.conformers.first}

    before do
      pending "Specs to be rewritten after architecture changed to use guard transitions; https://trello.com/c/bCSA9IbU/356--"
      conformer.conform mail.document
    end

    it "should clear its conformations" do
      expect(mail.conformations.count).to eq 1

      mail.title = '123'
      expect {mail.save}.to change {mail.reload.conformations.count}.from(1).to(0)
    end

    it "should not clear other conformations" do
      mail2 = FactoryGirl.create(:mail_with_direct_recipient_and_conformers)
      mail2.conformers.first.conform mail2.document

      expect(mail2.conformations.count).to be > 0

      mail.title = '123'
      mail.save
      
      expect(mail2.conformations.count).to be > 0
    end
  end

end
