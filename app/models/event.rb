class Event < ActiveRecord::Base
  include IceCube

  belongs_to :user

  serialize :schedule, IceCube::Schedule

  validates :title, :start_date, :user_id, presence: true

  def schedule=(new_schedule)
    return unless RecurringSelect.is_valid_rule?(new_schedule)

    the_schedule = Schedule.new(self.start_date)
    the_schedule.add_recurrence_rule(RecurringSelect.dirty_hash_to_rule(new_schedule))
    write_attribute(:schedule, the_schedule)
  end

  def self.feed_between(user_id, start_time, end_time)
    result = []
    events = Event.where("user_id = ? AND start_date <= ?", user_id, end_time)
    start_date = Date.parse(Time.parse(start_time).utc.to_s)
    end_date = Date.parse(Time.parse(start_time).utc.to_s)

    events.each do |event|
      if event.schedule.occurs_between?(start_date, end_date)
        event.schedule.occurrences_between(start_date, end_date).each do |instant|
          result.push({:id => event.id, :title => event.title, :start => instant})
        end
      end
    end
    result
  end
end
