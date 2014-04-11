FactoryGirl.define do
  factory :order, class: Documents::Order do
    title 'title'
    body 'body'

    sender_organization { FactoryGirl.create(:sender_organization) }
    recipient_organization { FactoryGirl.create(:recipient_organization) }

    deadline { DateTime.now + 10.days }

    task_list

    after(:build) do |instance, ev|
      instance.approver = FactoryGirl.create(:user, organization: instance.sender_organization)
      instance.executor = FactoryGirl.create(:user, organization: instance.sender_organization)
      instance.creator = FactoryGirl.create(:user, organization: instance.sender_organization)
    end

    after(:create) do |instance, ev|
      instance.transition_to!('draft')
    end

    factory :order_with_attachments do
      after(:create) do |instance, ev|
      end
    end

    factory :approved_order do
      after(:create) do |instance, ev|
        instance.transition_to! :prepared
        instance.transition_to! :approved
      end
    end

  end
end
