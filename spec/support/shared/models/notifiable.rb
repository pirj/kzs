shared_examples_for 'notifiable object' do |obj|
  it 'can get interesants' do
    expect(obj.interesants).to be_instance_of Array
  end
end