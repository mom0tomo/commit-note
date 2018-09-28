class Commit < ApplicationRecord
  belongs_to :user
  belongs_to :month

  validates :user_id, presence: true
  validates :month_id, presence: true
  validates :year, presence: true
  validates :day, presence: true
end
