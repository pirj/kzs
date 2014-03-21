FactoryGirl.define do
 factory :report, class: Documents::Report do

    title 'title'
    body 'body'

    sender_organization { FactoryGirl.create(:sender_organization) }
    recipient_organization { FactoryGirl.create(:recipient_organization) }

    order

    after(:build) do |instance, ev|
      user = instance.sender_organization.admin
      instance.approver = user
      instance.executor = user
      instance.creator = user
    end

    after(:create) do |instance,ev|
      instance.transition_to!('draft')
    end

  end
end