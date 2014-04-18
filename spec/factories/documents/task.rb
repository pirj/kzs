FactoryGirl.define do
  factory :document_task, class: Task do
    title 'task title'
    deadline { Time.now + 1.month }
    body 'task body'
    completed false
  end
end
