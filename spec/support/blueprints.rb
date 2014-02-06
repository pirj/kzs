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
#Post.make! {user: User.make!, subject: 'asd'}

User.blueprint do
  email { Faker::Internet.email}
  pwd = Faker::Lorem.characters(9)
  password { pwd }
  password_confirmation { pwd }
end

License.blueprint do

end
