FactoryGirl.define do
  sequence(:document_title) { | n | "Document_#{n}" }

  factory :document, class: Document do
    title { generate(:document_title) }
    body Populator.sentences(30..50)
  end

  factory :simple_document, class: Document do
    title { generate(:document_title) }
    body Populator.sentences(30..50)

    sender_organization { FactoryGirl.create(:sender_organization) }
    recipient_organization { FactoryGirl.create(:recipient_organization) }

    after(:build) do |instance, ev|
      instance.approver = FactoryGirl.create(:user, organization: instance.sender_organization)
      instance.executor = FactoryGirl.create(:user, organization: instance.sender_organization)
      instance.creator = FactoryGirl.create(:user, organization: instance.sender_organization)
    end

    after(:create) do |instance,ev|
      instance.accountable.transition_to!('draft')
    end

    factory :document_with_conformers do
      after(:build) do |instance, ev|
        instance.conformers << FactoryGirl.create(:user, organization: instance.sender_organization)
        instance.conformers << FactoryGirl.create(:user, organization: instance.sender_organization)
      end
    end

  end
end