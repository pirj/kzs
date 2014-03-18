FactoryGirl.define do
  factory :task_list do
    completed false

    after(:create) do |instance, ev|
      instance.tasks << FactoryGirl.create(:task, task_list: instance) << FactoryGirl.create(:task, task_list: instance)
    end
  end
end