require 'spec_helper'

describe Documents::Order do


  let(:order) { create(:order) }

  describe 'deadline' do
    context '+3 days from time now' do
      it 'should be valid' do
        order.deadline = DateTime.now + 3.days + 1.seconds
        expect(order).to be_valid
      end
    end

    context 'earlier than +3 days from time now' do
      before do
        order.deadline = DateTime.now + 2.days
        order.valid?
      end

      it 'should not be valid' do
        expect(order).to_not be_valid
      end

      it 'should display human error message' do
        expect(order.errors.messages[:deadline]).to be_include "должно быть не ранее #{(DateTime.now + 3.days).strftime("%d.%m.%Y")}"
      end

    end
  end

  describe 'has been minimum 1 task' do

    context 'with order in draft status' do

      let(:resource) { FactoryGirl.create :device }
      subject { build(:order) }
      it 'tasks number >= 1' do
        subject.should
      end

      it { should  }
    end
  end


end
