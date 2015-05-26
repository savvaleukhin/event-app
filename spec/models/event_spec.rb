require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should belong_to :user }

  it { should validate_presence_of :title }
  it { should validate_presence_of :start_date }
  it { should validate_presence_of :user_id }

  context 'schedule and rule' do
    let(:user) { create(:user) }
    subject { build(:event, title: 'Title', start_date: '2015-05-05', user_id: user) }

    context 'schedule string' do
      it 'does not save wrong schedule string' do
        subject.schedule = '123'
        subject.save
        expect(subject.schedule).to eq({})
      end
    end

    context 'converted_schedule' do
      it 'convetes hash of IceCube rule to IceCube schedule' do
        subject.schedule = {:validations=>{}, :rule_type=>"IceCube::DailyRule", :interval=>1}
        subject.save
        expect(subject.converted_schedule.to_s).to eq 'Daily'
      end

      it 'does not convert empty hash' do
        subject.schedule = {}
        subject.save
        expect(subject.converted_schedule).to eq nil
      end
    end
  end
end
