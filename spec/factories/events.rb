FactoryGirl.define do
  factory :event do
    title "MyString"
    schedule nil
    start_date '2015-05-05'
  end

  factory :invalid_event, class: 'Event' do
    title nil
    schedule nil
    start_date nil
  end
end
