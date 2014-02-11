# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { | n | "example#{n}@example.com" }
    password "password"
    password_confirmation "password"

  end

  factory :admin, :parent => :user do

  end
end