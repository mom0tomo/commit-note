class User < ApplicationRecord
  has_many :commits, dependent: :destroy
  has_many :repositories, dependent: :destroy

  validates :uid, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :latest_sign_in_at, presence: true

  has_secure_password
end
