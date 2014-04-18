FactoryGirl.define do
  sequence(:task_title) { | n | "Task_#{n}" }
  sequence(:task_text) { | n | "Texts for task##{n}" }

  factory :task, class: Tasks::Task do
    title { generate(:task_title) }
    text { generate(:task_text) }
    started_at { Time.now }
    finished_at { Time.now + 1.month }
  end
end
