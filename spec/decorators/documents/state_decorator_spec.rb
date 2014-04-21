require "spec_helper"

describe Documents::StateDecorator do
  describe '#to_humanize_state' do
    let(:document) do
      document = Document.new.tap do |d|
        d.state = 'prepared'
        d.accountable = Documents::Order.new
      end
    end

    let(:decorator) { Documents::StateDecorator.new(document) }

    context 'with current state' do
      subject{decorator.to_humanize_state(:prepared)}
      it{ should match "Сохранить"}
    end

    context 'with other state' do
      subject{decorator.to_humanize_state(:approved)}
      it{ should_not match "Подписать"}
    end
  end
end