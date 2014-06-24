FactoryGirl.define do
  factory :simple_organization, class: Organization do
    title "OOO Simple Organization"
    short_title "Simple Organization"
  end

  factory :organization, class: Organization do
    title 'Organization Full Name'
    short_title 'Organization'
    type_of_ownership 'TypeNested'

    admin { FactoryGirl.create(:user) }
    accountant { FactoryGirl.create(:user) }
    director { FactoryGirl.create(:user) }

    after(:build) do |instance, ev|
      instance.admin.organization = instance
      instance.admin.save!

      instance.director.organization = instance
      instance.director.save!

      instance.accountant.organization = instance
      instance.accountant.save!
    end

    factory :sender_organization, class: Organization do
      title "OOO Sender Organization"
      short_title "Sender Organization"
    end
    factory :recipient_organization, class: Organization do
      title "OOO Recipient Organization"
      short_title "Recipient Organization"
    end

  end
end