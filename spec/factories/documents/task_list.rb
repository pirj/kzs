FactoryGirl.define do
  factory :task_list do
    after(:build) do |instance, ev|
      instance.tasks << FactoryGirl.build(:document_task, task_list: instance) << FactoryGirl.build(:document_task, task_list: instance)
    end
  end
end
