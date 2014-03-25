FactoryGirl.define do
  factory :task do
    title 'task titlle'
    deadline { Time.now + 1.month }
    body 'task body'
    completed false
  end
end
