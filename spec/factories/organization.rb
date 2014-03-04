FactoryGirl.define do

  factory :sender_organization, class: Organization do
    title "OOO Sender Organization"
    short_title "Sender Organization"

    factory :full_sender_organization do
      director { create(:user) }
      accountant { create(:user) }
      admin { create(:user) }
    end
  end

  factory :recipient_organization, class: Organization do
    title "OOO Recipient Organization"
    short_title "Recipient Organization"

    factory :full_recipient_organization do
      director { create(:user) }
      accountant { create(:user) }
      admin { create(:user) }
    end
  end
end