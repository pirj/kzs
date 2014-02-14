# fun coding: UTF-8
require 'machinist/active_record'

Organization.blueprint do
  director = User.make!
  accountant = User.make!
  admin = User.make!
  title {Faker::Lorem.sentence}
  logo { File.open("#{Rails.root}/spec/fixtures/images/logo-cyclone.png")}
  director_id {director.id}
  accountant_id {accountant.id}
  admin_id {admin.id}
end

User.blueprint do
  username { Faker::Lorem.word }
  email { Faker::Internet.email }
  pwd = Faker::Lorem.characters(9)
  password { pwd }
  password_confirmation { pwd }
end

Group.blueprint do
  title {Faker::Lorem.sentence}
end

Organization.blueprint do
  title {Faker::Lorem.sentence}
end

Permit.blueprint do
  number {Faker::Number.number(100)}
end

Vehicle.blueprint do
  sn_number { 111 }
  first_letter { 'A' }
  second_letter { 'B' }
  third_letter { 'C' }
end

CarRegion.blueprint do
  # Attributes here
end
