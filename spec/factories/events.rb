FactoryGirl.define do
  sequence :title do |n|
    "Title of event #{n}"
  end

  factory :event do
    title "MyString"
    schedule nil
    start_date '2015-05-05'

    factory :event_with_user do
      user
    end

    factory :event_list do
      title
    end
  end

  factory :invalid_event, class: 'Event' do
    title nil
    schedule nil
    start_date nil
  end
end
