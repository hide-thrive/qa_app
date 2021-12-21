class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
  uniqueness: { case_sensitive: false }

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
end
