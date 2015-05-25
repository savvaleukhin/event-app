class Event < ActiveRecord::Base
  include IceCube

  belongs_to :user

  validates :title, :start_date, :user_id, presence: true

  serialize :schedule, Hash

  def schedule=(new_schedule)
    write_attribute(:schedule, RecurringSelect.dirty_hash_to_rule(new_schedule).to_hash)
  end

  def converted_schedule
    the_schedule = Schedule.new(self.start_date)
    the_schedule.add_recurrence_rule(RecurringSelect.dirty_hash_to_rule(self.schedule))
    the_schedule
  end
end
