class Repository < ApplicationRecord
  belongs_to :user
  belongs_to :month

  validates :user_id, presence: true
  validates :month_id, presence: true
end
