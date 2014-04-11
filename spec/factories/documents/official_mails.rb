# Добавляет к Accountable приаттаченный документ mail_approved
def add_attachment_to(accountable)
  attachment = FactoryGirl.create(:approved_mail)
  accountable.attached_documents << attachment.document
end

FactoryGirl.define do
  factory :mail, class: Documents::OfficialMail do

    # Общее
    title 'title'
    body 'body'
    sender_organization { FactoryGirl.create(:sender_organization) }

    after(:build) do |instance, ev|
      instance.approver = FactoryGirl.create(:user, organization: instance.sender_organization)
      instance.executor = FactoryGirl.create(:user, organization: instance.sender_organization)
      instance.creator = FactoryGirl.create(:user, organization: instance.sender_organization)
    end

    after(:create) do |instance,ev|
      instance.transition_to!('draft')
    end

    # Частные случаи

    # С адресатом
    factory :mail_with_direct_recipient do
      recipient_organization { FactoryGirl.create(:recipient_organization) }

      # Подготовленное письмо с одним адресатом
      factory :prepared_mail do
        after(:create) do |instance, ev|
          instance.transition_to! :prepared
        end

        # Подготовленное письмо с одним адресатом и согласующими
        factory :mail_with_direct_recipient_and_conformers do
          after(:build) do |instance, ev|
            instance.conformers << FactoryGirl.create(:user, organization: instance.sender_organization)
            instance.conformers << FactoryGirl.create(:user, organization: instance.sender_organization)
          end
        end
        
        # Подписанное письмо с одним адресатом
        factory :approved_mail do
          after(:create) do |instance, ev|
            instance.transition_to! :approved
          end
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
    end

    # С приаттаченным 1 или более mail_approved
    # Базовая factory - c одним
    factory :mail_with_attachment do
      recipient_organization

      after(:create) { |instance,ev| add_attachment_to instance }

      # С двумя
      factory :mail_with_two_attachments do
        after(:create) { |instance,ev| add_attachment_to instance }        
      end
    end
  end
end