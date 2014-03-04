FactoryGirl.define do
  factory :organization do

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