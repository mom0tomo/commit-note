class Month < ApplicationRecord
  has_many :commits
  has_many :repositories

  validates :name, presence: true
end
