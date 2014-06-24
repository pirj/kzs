require 'spec_helper'

describe Tasks::TaskSerializer do

  context 'Tasks API serializer' do

    let(:time_freeze) { "2014-05-27 14:50:09 +0400" }

    let(:task) { Tasks::Task.new(title: 'Task One', text: 'Desc', started_at: nil, finished_at: nil ) }

    subject { Tasks::TaskSerializer.new(task) }

    it('Should have base keys and a root key') { expect(subject.to_json).to eql('{"task":{"id":null,"title":"Task One","started_at":null,"finished_at":null,"parent_id":null,"state":null,"description":"Desc","start_date":null,"duration":0,"executor":null,"inspector":null,"checklists":[]}}')}

    context 'Check for user serialization' do
      let(:executor) { build :user, first_name: 'Sam', last_name: 'Serious'}
      let(:inspector) { build :user, first_name: 'Bill', last_name: 'Murray'}
      let(:task) do
        task = Tasks::Task.new title: 'Task One', text: 'Desc'
        task.tap do |t|
          t.executor = executor
          t.inspector = inspector
        end
      end

      subject { JSON.parse(Tasks::TaskSerializer.new(task).to_json) }

      it "JSON should contain executor and inspector first_name_and_last_name" do
        expect(subject).to have_key "task"
        expect(subject["task"]).to have_key "executor"
        expect(subject["task"]).to have_key "inspector"
        expect(subject["task"]["inspector"]).to have_key "first_name_with_last_name"
        expect(subject["task"]["executor"]).to have_key "first_name_with_last_name"
      end


    end
  end
end