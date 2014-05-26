FactoryGirl.define do
  sequence(:task_title) { | n | "Task_#{n}" }
  sequence(:task_text) { | n | "Texts for task##{n}" }

  factory :task, class: Tasks::Task do
    title { generate(:task_title) }
    text { generate(:task_text) }
    started_at { Time.now }
    finished_at { Time.now + 1.month }

    after(:build) do |instance, ev|
      _organization = FactoryGirl.create(:user).organization
      instance.organization = _organization
      instance.approvers << FactoryGirl.create(:user, organization: _organization)
      instance.approvers << FactoryGirl.create(:user, organization: _organization)
      instance.executors << FactoryGirl.create(:user, organization: _organization)
      instance.executors << FactoryGirl.create(:user, organization: _organization)
    end
  end
end
