FactoryGirl.define do
  factory :simple_organization, class: Organization do
    title "OOO Simple Organization"
    short_title "Simple Organization"
  end

  factory :sender_organization, class: Organization do
    title "OOO Sender Organization"
    short_title "Sender Organization"

    after(:create) do |instance, ev|
      user = FactoryGirl.create(:user, organization: instance)
      instance.admin = user
      instance.accountant = user
      instance.director = user
    end
  end

  factory :recipient_organization, class: Organization do
    title "OOO Recipient Organization"
    short_title "Recipient Organization"

    after(:create) do |instance, ev|
      user = FactoryGirl.create(:user, organization: instance)
      instance.admin = user
      instance.accountant = user
      instance.director = user
    end
  end
end