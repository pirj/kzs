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
  organization = Organization.make!
  pwd = Faker::Lorem.characters(9)
  username { Faker::Lorem.word }
  email { Faker::Internet.email }
  password { pwd }
  password_confirmation { pwd }
  organization_id { organization.id }
  first_name { Faker::Lorem.word }
  last_name { Faker::Lorem.word }
  middle_name { Faker::Lorem.word }
  position { Faker::Lorem.word }
end

Group.blueprint do
  title {Faker::Lorem.sentence}
end

Organization.blueprint do
  title {Faker::Lorem.sentence}
end

Permit.blueprint do
  number {Faker::Number.number(100)}
  permit_type {'vehicle' or 'user'}
  start_date { Date.today }
  expiration_date { Date.today + 5.days }
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

Document.blueprint do
  title {Faker::Lorem.sentence}
  body {Faker::Lorem.paragraph}
  sender_organization { Organization.make! }
  recipient_organization { Organization.make! }
  approver {User.make!}
  executor {User.make!}
end

Documents::OfficialMail.blueprint do
  document
  recipients(3)
end
OrdersConversation.blueprint do
  # Attributes here
end
