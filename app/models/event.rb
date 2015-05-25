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
end
