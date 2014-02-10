#FactoryGirl.define do
#  factory :document do
#    title Proc.new{ Faker::Lorem.words(12) }
#    body Proc.new{ Populator.sentences(30..50) }
#    sender_organization lambda { Organization.last }
#    recipient_organization lambda { Organization.last }
#  end
#end