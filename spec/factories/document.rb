FactoryGirl.define do
  factory :order, class: Documents::Order do
    title 'title'
    body 'body'

    sender_organization { FactoryGirl.create(:full_sender_organization) }
    recipient_organization { FactoryGirl.create(:full_recipient_organization) }
    approver { FactoryGirl.create(:user) }
    executor { FactoryGirl.create(:user) }
    creator { FactoryGirl.create(:user) }

    deadline { DateTime.now + 10.days }

  end
end