require 'spec_helper'

describe Tasks::Task do
  subject!(:task) { FactoryGirl.create(:tasks_task) }
  it{should respond_to :subtasks}
  it{should respond_to :parent_id}
  it{should respond_to :parent}

  it_behaves_like 'notifiable object'

  context "when using notifications" do
    before :each do
      task.clear_notifications
    end
    it 'can have multiple notifications per user' do
      expect {2.times {task.notify_interesants(only: :inspector)}}.to change{task.notifications.where(user_id: task.inspector.id).count}.from(0).to(2)
    end
  end

  context('instantiate subtask'){
    it{ expect { Tasks::Task.new(parent_id: 1) }.not_to raise_error }
  }

  context('parent task') do
    let(:subtasks) { 5.times.map { FactoryGirl.build(:tasks_plain_task) } }
    let(:task){ FactoryGirl.build(:tasks_plain_task, subtasks: subtasks) }
    context('subtasks') do
      subject{task.subtasks}
      it{ should be_a_kind_of(Array)}
    end
  end

  context('scopes') do
    context('.overdue') do
      let!(:one_day_past) { 
        a=FactoryGirl.create(:tasks_task) 
        a.update_attributes(started_at: 2.days.ago, finished_at: 1.day.ago)
        a
      }

      let!(:one_day_left) { FactoryGirl.create(:tasks_task, finished_at: Time.now + 1.day) }
      subject { Tasks::Task.overdue }
      it { should eq [one_day_past]}
    end
  end
end
