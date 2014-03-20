FactoryGirl.define do
  factory :mail, class: Documents::OfficialMail do

    # Общее
    title 'title'
    body 'body'
    sender_organization

    after(:build) do |instance, ev|
      user = instance.sender_organization.admin
      instance.approver = user
      instance.executor = user
      instance.creator = user
    end

    after(:create) do |instance,ev|
      instance.transition_to!('draft')
    end

    # Частные случаи

    # С адресатом
    factory :mail_with_direct_recipient do
      recipient_organization

      factory :approved_mail do
        after(:create) do |instance, ev|
          instance.transition_to! :prepared
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

      factory :mail_with_attached_documents do
        after(:create) do |instance, ev|
          instance.attached_documents << FactoryGirl.create(:mail_with_direct_recipient).document << FactoryGirl.create(:mail_with_direct_recipient).document
        end
      end
    end

    # Подписанная, с адресатом
    factory :mail_approved do
      recipient_organization

      after(:create) do |instance,ev|
        instance.transition_to!('prepared')
        instance.transition_to!('approved')
      end
    end

    # С приаттаченным mail_approved
    factory :mail_with_attachment do
      recipient_organization

      after(:create) do |instance,ev|
        attachment = FactoryGirl.create(:mail_approved)
        instance.attached_documents << attachment.document
      end
    end
  end
end