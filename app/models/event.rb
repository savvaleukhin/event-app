class Event < ActiveRecord::Base
  include IceCube
  serialize :schedule, IceCube::Schedule

  validates :title, :start_date, presence: true

  def schedule
    Schedule.new(start_date) do |s|
      s.add_recurrence_rule Rule.daily(1).count(7)
    end
  end
end
