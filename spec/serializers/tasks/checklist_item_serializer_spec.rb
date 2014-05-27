require 'spec_helper'

describe Tasks::ChecklistItemSerializer do

  context 'Tasks API serializer' do
    let(:item){ Tasks::ChecklistItem.new(:name => 'name', :description => 'desc', :checklist_id=> 1, :checked=> nil, :finished_at => nil) }
    subject{ Tasks::ChecklistItemSerializer.new(item) }
    it { expect(subject.to_json).to eql('{"checklist_item":{"id":null,"deadline":null,"checked":null,"description":"desc","name":"name"}}')}

  end
end