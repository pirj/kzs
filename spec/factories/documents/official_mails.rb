# Добавляет к Accountable приаттаченный документ mail_approved
def add_attachment_to(accountable)
  attachment = FactoryGirl.create(:approved_mail)
  accountable.attached_documents << attachment.document
end

FactoryGirl.define do
  factory :mail, class: Documents::OfficialMail do

    document { FactoryGirl.build(:simple_document) }

    after(:create) do |instance,ev|
      instance.transition_to!('draft')
    end

    factory :mail_without_recipient do
      after(:build) do |instance, ev|
        instance.document.recipient = nil
      end
    end


    # Подготовленное письмо с одним адресатом
    factory :prepared_mail do
      after(:create) do |instance, ev|
        instance.transition_to! :prepared
      end

      # Подготовленное письмо с одним адресатом и согласующими
      factory :mail_with_direct_recipient_and_conformers do
        document { FactoryGirl.build(:document_with_conformers) }
      end

      # Подписанное письмо с одним адресатом
      factory :approved_mail do
        after(:create) do |instance, ev|
          instance.transition_to! :approved
        end
      end
    end

    # С несколькими адресатами
    factory :mail_with_many_recipients do
      recipients {
        5.times.map do
          FactoryGirl.create(:recipient_organization)
        end
      }

      after(:build) do |instance, env|
        instance.document.recipient_organization = nil
      end
    end

    # С приаттаченным 1 или более mail_approved
    # Базовая factory - c одним
    factory :mail_with_attachment do
      after(:create) { |instance,ev| add_attachment_to instance }

      # С двумя
      factory :mail_with_two_attachments do
        after(:create) { |instance,ev| add_attachment_to instance }        
      end
    end
  end
end