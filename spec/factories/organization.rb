FactoryGirl.define do
  factory :simple_organization, class: Organization do
    title "OOO Simple Organization"
    short_title "Simple Organization"
  end

  factory :sender_organization, class: Organization do
    title "OOO Sender Organization"
    short_title "Sender Organization"

    after(:create) do |instance, ev|
      instance.admin = FactoryGirl.create(:user, organization: instance)
      instance.accountant = FactoryGirl.create(:user, organization: instance)
      instance.director = FactoryGirl.create(:user, organization: instance)
      instance.save!
    end
  end

  factory :recipient_organization, class: Organization do
    title "OOO Recipient Organization"
    short_title "Recipient Organization"

    after(:create) do |instance, ev|
      instance.admin = FactoryGirl.create(:user, organization: instance)
      instance.accountant = FactoryGirl.create(:user, organization: instance)
      instance.director = FactoryGirl.create(:user, organization: instance)
      instance.save!
    end
  end
end