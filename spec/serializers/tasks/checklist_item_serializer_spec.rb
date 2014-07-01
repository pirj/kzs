require 'spec_helper'

describe Tasks::ChecklistItemSerializer do

  context 'Tasks API serializer' do
    let!(:task) { FactoryGirl.create(:tasks_task_with_checklist) }
    subject{ Tasks::ChecklistItemSerializer.new(task.checklists.first.checklist_items.first) }

    it {expect(subject.to_json).to eql('{"checklist_item":{"id":1,"deadline":null,"checked":"false","description":null,"name":"item","task_id":1}}')}

  end
end