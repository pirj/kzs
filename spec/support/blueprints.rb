# fun coding: UTF-8
require 'machinist/active_record'

Organization.blueprint do
  title {Faker::Lorem.sentence}
  logo { Tempfile.new(Rails.root.join('spec', 'files', 'logo-cyclone.png'), 'image/png') }
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
