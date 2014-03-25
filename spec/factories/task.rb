FactoryGirl.define do
  factory :task do
    title 'task title'
    deadline { Time.now + 1.month }
    body 'task body'
    completed false
  end
end
