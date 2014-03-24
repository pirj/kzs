FactoryGirl.define do
  factory :simple_organization, class: Organization do
    title "OOO Simple Organization"
    short_title "Simple Organization"
  end

  factory :organization do
    title "OOO Organization"
    short_title "Organization"

    after(:create) do |instance, ev|
      instance.admin = FactoryGirl.create(:user, organization: instance)
      instance.accountant = FactoryGirl.create(:user, organization: instance)
      instance.director = FactoryGirl.create(:user, organization: instance)
      instance.save!
    end

    factory :sender_organization, class: Organization
    factory :recipient_organization, class: Organization
  end

  
end