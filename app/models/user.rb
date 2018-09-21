class User < ApplicationRecord
  validates :uid, presence: true, length: { maximum: 50 }

  has_secure_password
end
