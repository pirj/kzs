require 'spec_helper'

describe Tasks::TaskSerializer do

  context 'Tasks API serializer' do

    let(:time_freeze) { "2014-05-27 14:50:09 +0400" }

    let(:task) { Tasks::Task.new(title: 'Task One', text: 'Desc', started_at: nil, finished_at: nil ) }

    subject { Tasks::TaskSerializer.new(task) }

    it { expect(subject.to_json).to eql('{"task":{"id":null,"title":"Task One","started_at":null,"finished_at":null,"parent_id":null,"state":null,"description":"Desc","start_date":null,"duration":0,"executor":null,"inspector":null,"checklists":[]}}')}
  end
end