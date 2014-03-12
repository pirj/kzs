FactoryGirl.define do
  factory :mail, class: Documents::OfficialMail do
    title 'title'
    body 'body'
    sender_organization

    factory :mail_with_direct_recipient do
      recipient_organization
    end

    factory :mail_with_many_recipients do
      recipients {
        5.times.map do
          FactoryGirl.create(:recipient_organization)
        end
      }
    end

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