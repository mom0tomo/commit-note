class User < ApplicationRecord
  has_many :commits, dependent: :destroy
  has_many :repositories, dependent: :destroy

  validates :uid, presence: true, length: { maximum: 50 }

  has_secure_password
end
