class Exercise < ApplicationRecord
  belongs_to :user
  validates_presence_of :duration_in_min, :workout, :workout_date
  validates :duration_in_min, numericality: true
end
