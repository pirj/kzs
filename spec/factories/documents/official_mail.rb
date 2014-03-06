FactoryGirl.define do
  factory :mail, class: Documents::OfficialMail do
    title 'title'
    body 'body'
    sender_organization { FactoryGirl.create(:sender_organization) }

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
  end
end