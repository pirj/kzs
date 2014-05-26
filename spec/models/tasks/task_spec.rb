require 'spec_helper'

describe Tasks::Task do
  subject { Tasks::Task.new() }
  it{should respond_to :subtasks}
  it{should respond_to :parent_id}
  it{should respond_to :parent}

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
end
