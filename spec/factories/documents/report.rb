FactoryGirl.define do
  factory :report, class: Documents::Report do
    # title 'title'
    # body 'body'
    #
    # sender_organization { FactoryGirl.create(:sender_organization) }
    # recipient_organization { FactoryGirl.create(:recipient_organization) }

    # order

    # after(:build) do |instance, ev|
    #   instance.approver = FactoryGirl.create(:user, organization: instance.sender_organization)
    #   instance.executor = FactoryGirl.create(:user, organization: instance.sender_organization)
    #   instance.creator = FactoryGirl.create(:user, organization: instance.sender_organization)
    # end

    # Создаем распоряжение и обязательно привязываем по отправителю-получателю
    # Отправитель распоряжения является получателем
    after(:build) do |instance, ev|
      instance.order = FactoryGirl.create(:order)
      instance.document = FactoryGirl.build(:simple_document,
                                            sender_organization: instance.order.recipient_organization,
                                            recipient_organization: instance.order.sender_organization
                                            )
    end
    after(:create) do |instance, ev|
      instance.transition_to!('draft')
    end
  end
end
