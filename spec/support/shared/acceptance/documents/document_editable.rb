# ситуации,когда документ можно редактировать
shared_examples_for 'document_editable' do
  describe 'allow to edit document before sent' do
    subject { page }

    context 'draft state' do
      it { should have_content 'Редактировать' }
    end

    context 'prepared state' do
      background do
        document.transition_to!(:draft)
        document.transition_to!(:prepared)
        visit path
      end

      it { should have_content 'Редактировать' }
    end

    context 'approved state' do
      background do
        document.transition_to!(:draft)
        document.transition_to!(:prepared)
        document.transition_to!(:approved)
        visit path
      end
      it { should_not have_content 'Редактировать' }
    end

    context 'sent state' do
      background do
        document.transition_to!(:draft)
        document.transition_to!(:prepared)
        document.transition_to!(:approved)
        document.transition_to!(:sent)
        visit path
      end
      it { should_not have_content 'Редактировать' }
    end

  end
end
