FactoryGirl.define do
  sequence(:email) { | n | "user#{n}@mail.com" }
  sequence(:first_name) { | n | "Ivan_#{n}" }
  sequence(:last_name) { | n | "Shestakovich_#{n}" }

  factory :user do
    first_name { generate(:first_name) }
    last_name { generate(:last_name) }
    middle_name 'Valerievich'

    position 'SAKE-man'

    password "password"
    password_confirmation "password"

    after(:build) do |instance, ev|
      email = generate(:email)
      instance.email = email
      instance.username = email
    end

    factory :user_with_organization do
      organization { FactoryGirl.create(:organization) }
    end

  end

end
