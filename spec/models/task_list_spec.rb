require 'spec_helper'

describe TaskList do
  subject { task_list.completed }

  let(:task_list) { FactoryGirl.create(:task_list) }

  describe '#completed' do

    before do
      tasks = 5.times.map { FactoryGirl.create(:document_task, task_list: task_list) }
      task_list.tasks << tasks
      task_list.tasks.each do |t|
        t.completed = true
        t.save!
      end
    end

    context 'with finished tasks' do
      it { should be_true }

      it 'should persist over reloading' do
        task_list.reload
        task_list.completed.should be_true
      end
    end

    context 'with incomplete tasks' do
      before do
        task = task_list.tasks.last
        task.update_attributes(completed: false)
      end

      it { should be_false }

      it 'should persist over reloading' do
        task_list.reload
        expect(task_list.completed).to be_false
      end
    end

  end
end
