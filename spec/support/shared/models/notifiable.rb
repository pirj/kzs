shared_examples_for 'notifiable object' do #|obj|

  let (:user) { FactoryGirl.create(:user_with_organization) }
  let (:user2) { FactoryGirl.create(:user_with_organization) }

  before do
    Notification.destroy_all
  end

  it 'can get interesants' do
    expect(subject.interesants).to be_instance_of Array
  end

  it 'can have notifications' do
    expect(subject.notifications).to be_instance_of Array
  end

  it 'can get class interesants' do
    expect(subject.class.interesants).to be_instance_of Array
  end

  it 'can clear notifications' do
  expect { subject.notifications.create(user: user) }
    .to change{subject.notifications.count}.from(0).to(1)

  expect { subject.clear_notifications for: user}
    .to change{subject.notifications.count}.from(1).to(0)
  end

  it 'can clear notifications for specified user' do
    subject.notifications.create(user: user)
    subject.notifications.create(user: user2)

    expect {subject.clear_notifications(for: user) }.to change{subject.notifications.count}.from(2).to(1)
  end

  it 'can check if user have notification' do
    expect {subject.notifications.create(user: user)}.to change {subject.has_notification_for? user}.from(false).to(true)
  end

  context 'in advanced mode' do
    it 'can create single notifications' do
      expect { subject.notifications.create(user: FactoryGirl.create(:user_with_organization)) }
        .to change{subject.notifications.count}.from(0).to(1)
    end

    it 'can create multiple notifications for the same object and same user' do
      expect {2.times {subject.notifications.create(user: user)}}.not_to raise_error
      expect(subject).to have(2).notifications
    end

    it 'can set/read notification message and modifier user id' do
      expect {subject.notifications.create(user: user, changer: user2, message: 'test')}.not_to raise_error
    end
  end

  it 'can get array of notifications for the user' do
    expect {subject.notifications.create(user: user)}.to change {subject.notifications.count}.from(0).to(1)
    expect {subject.notifications.create(user: user2)}.to change {subject.notifications.count}.from(1).to(2)

    expect(subject.notifications(for:user)).to be_instance_of Array
    expect(subject.notifications(for: user).count).to be == 1
  end

  context "in single mode" do
    it 'can\'t create 2 notifications for the same object' do
      expect {2.times {subject.notifications.create(user: user)}}.to raise_error
    end
  end

end