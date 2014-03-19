require 'spec_helper'

describe TaskList do

  let!(:task_list) { FactoryGirl.create(:task_list) }
  let!(:tasks) { 5.times.map {FactoryGirl.create(:task, task_list: task_list) }}


  # TODO-tagir: поменяй здесь названия методов на те, что в самой модели
  # сейчас тесты проходят

  describe '#completed' do
    subject { task_list.completed }

    context 'with finished tasks' do

      before do
        task_list.tasks.each do |t|
          t.update_attributes(completed: true)
        end
      end


      it { should be_true }


      it 'should persist' do
        task_list.reload
        task_list.completed.should be_true
      end
    end



    context 'with incomplete tasks' do
      before do
        task_list.tasks.each do |t|
          t.completed = true
        end

        task_list.tasks.last.completed = false
        task_list.save!
      end

      it { should be_false }

      it 'should save status' do
        task_list.reload
        expect(task_list.completed).to be_false
      end
    end


  end
end
