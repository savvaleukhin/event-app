class Event < ActiveRecord::Base
  include IceCube
  serialize :schedule, IceCube::Schedule

  validates :title, :start_date, presence: true

  def schedule=(new_schedule)
    return unless RecurringSelect.is_valid_rule?(new_schedule)

    the_schedule = Schedule.new(self.start_date)
    the_schedule.add_recurrence_rule(RecurringSelect.dirty_hash_to_rule(new_schedule))
    write_attribute(:schedule, the_schedule)
  end
end
