require 'spec_helper'

describe Document do

  context 'when have conformations' do
    before :each do
      @mail = FactoryGirl.create(:mail_with_direct_recipient_and_conformers)
      @conformer = @mail.conformers.first
      @conformer.conform @mail
    end

    context 'and being updated' do
      it "should clear its conformations" do
        @mail.reload.conformations.count.should be > 0

        @mail.title = '123'
        @mail.save

        @mail.reload.conformations.count.should == 0
      end

      it "should not clear other conformations" do
        mail2 = FactoryGirl.create(:mail_with_direct_recipient_and_conformers)
        mail2.conformers.first.conform mail2

        mail2.reload.conformations.count.should be > 0

        @mail.title = '123'
        @mail.save

        mail2.reload.conformations.count.should be > 0
      end
    end

    context 'and being destroyed' do
      it 'should clear its conformations' do
        id = @mail.document.id
        
        # Иммитируем удаление из БД (в обычной ситуации использование destroy невозможно)
        @mail.document.send :destroy

        Conformation.where('document_id = ?', id).count.should == 0
      end
    end
  end

end
