FactoryGirl.define do
  sequence(:tasks_task_title) { | n | "Task_#{n}" }
  sequence(:tasks_task_text) { | n | "Texts for task##{n}" }

  factory :tasks_plain_task, class: Tasks::Task do
    title { generate(:tasks_task_title) }
    text { generate(:tasks_task_text) }
    started_at { Time.now }
    finished_at { Time.now + 1.month }

    factory :tasks_task, class: Tasks::Task do
      after(:build) do |instance, ev|
        organization = FactoryGirl.create(:organization)
        instance.organization = organization
        instance.inspectors << FactoryGirl.create(:user, organization: organization)
        instance.executors << FactoryGirl.create(:user, organization: organization)
      end
    end
  end
end
