FactoryGirl.define do
  sequence(:email) { | n | "user#{n}@mail.com" }
  sequence(:first_name) { | n | "Ivan_#{n}" }
  sequence(:last_name) { | n | "Shestakovich_#{n}" }

  factory :user do
    email { generate(:email) }

    first_name { generate(:first_name) }
    last_name { generate(:last_name) }
    middle_name 'Valerievich'

    position 'SAKE-man'
    organization { FactoryGirl.create(:simple_organization) }

    password "password"
    password_confirmation "password"

  end
end