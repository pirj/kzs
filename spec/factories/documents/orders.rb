FactoryGirl.define do
  factory :order, class: Documents::Order do
    title 'title'
    body 'body'

    sender_organization { FactoryGirl.create(:sender_organization) }
    recipient_organization { FactoryGirl.create(:recipient_organization) }

    deadline { DateTime.now + 10.days }

    after(:build) do |instance, ev|
      user = instance.sender_organization.admin
      instance.approver = user
      instance.executor = user
      instance.creator = user
    end

    factory :order_with_attachments do
      after(:create) do |instance, ev|
        # create attached orders
      end
    end

  end


end