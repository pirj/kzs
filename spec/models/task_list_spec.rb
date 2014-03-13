require 'spec_helper'

describe TaskList do

  let!(:task_list) { FactoryGirl.create(:task_list) }
  let!(:tasks) { 5.times.map {FactoryGirl.create(:task, task_list: task_list) }}


  # TODO-tagir: поменяй здесь названия методов на те, что в самой модели
  # сейчас тесты проходятю

  describe '#update_status' do
    context 'all tasks completed' do

      before do
        task_list.tasks.each do |t|
          t.completed = true
        end
        task_list.save!
      end


      it 'should be done' do
        expect(task_list.completed).to be_true
      end

      it 'should save status' do
        task_list.reload
        expect(task_list.completed).to be_true
      end
    end



    context 'several tasks uncompleted' do
      before do
        task_list.tasks.each do |t|
          t.completed = true
        end

        task_list.tasks.last.completed = false
        task_list.save!
      end

      it 'should not be done' do
        expect(task_list.completed).to be_false
      end

      it 'should save status' do
        task_list.reload
        expect(task_list.completed).to be_false
      end
    end


  end
end
