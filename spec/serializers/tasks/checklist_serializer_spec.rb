require 'spec_helper'

describe Tasks::ChecklistSerializer do

  context 'Tasks API serializer' do

    let(:checklist) { Tasks::Checklist.new(:name => 'checklist') }
    subject{ Tasks::ChecklistSerializer.new(checklist) }

    it { expect(subject.to_json).to eql('{"checklist":{"id":null,"name":"checklist","created_at":null,"checklist_items":[]}}')}

  end
end