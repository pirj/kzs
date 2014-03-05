FactoryGirl.define do
  factory :organization do
    title { Faker::Lorem.words(4)}
    short_title { Faker::Lorem.words(4)}

    #director { create(:user) }
    #accountant { create(:user) }
    #admin { create(:user) }

    factory :sender_organization do
      title "OOO Sender Organization"
      short_title "Sender Organization"

    end

    factory :recipient_organization do
      title "OOO Recipient Organization"
      short_title "Recipient Organization"
    end
  end
end