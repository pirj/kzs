FactoryGirl.define do
  factory :task_list do
    after(:build) do |instance, ev|
      instance.tasks << FactoryGirl.build(:task, task_list: instance) << FactoryGirl.build(:task, task_list: instance)
    end
  end
end