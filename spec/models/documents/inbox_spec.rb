require 'spec_helper'

describe Documents::Inbox do
  let(:user) { FactoryGirl.create(:user) }
  let(:organization) { user.organization }

  let(:mail) { FactoryGirl.create(:mail_with_direct_recipient) }

  let(:inbox_mail) do
    mail = FactoryGirl.build(:mail)
    mail.recipient_organization = organization
    mail.save!
    mail.transition_to!(:prepared)
    mail.transition_to!(:approved)
    mail.transition_to!(:sent)
  end

  let(:inbox_order) do
    order = FactoryGirl.build(:order)
    order.recipient_organization = organization
    order.save!
    order.transition_to!(:prepared)
    order.transition_to!(:approved)
    order.transition_to!(:sent)
  end

  subject { Documents::Inbox.new(user, organization) }

  before do
    inbox_mail
    inbox_order
    mail
  end

  context '#count_by_type' do
    it('should return total without arguments') { subject.count_by_type.should eq 2 }
    it('should return mail count') { subject.count_by_type(:mails).should eq 1 }
    it('should return orders count') { subject.count_by_type(:orders).should eq 1 }
    it('should return reports count') { subject.count_by_type(:reports).should eq 0 }
  end

  its(:count) { should eq 2 }

  its(:mail_count) { should eq 1 }

  its(:order_count) { should eq 1 }

  its(:report_count) { should eq 0 }

end
