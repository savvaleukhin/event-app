require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should belong_to :user }

  it { should validate_presence_of :title }
  it { should validate_presence_of :start_date }
  it { should validate_presence_of :user_id }

  context 'schedule string' do
    subject { build(:event, title: 'Title', start_date: '2015-05-05') }

    it 'saves write schedule string' do
      subject.schedule = '{"interval":1,
                          "until":null,
                          "count":null,
                          "validations":null,
                          "rule_type":"IceCube::DailyRule"}'
      subject.save
      expect(subject.schedule.to_s).to eq 'Daily'
    end

    it 'does not save wrong schedule string' do
      subject.schedule = '123'
      subject.save
      expect(subject.schedule).to eq nil
    end
  end
end
