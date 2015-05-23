class Event < ActiveRecord::Base
  validates :title, :schedule, presence: true
end
