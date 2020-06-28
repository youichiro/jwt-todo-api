class User < ApplicationRecord
  has_secure_password
  has_many :tasks, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, length: { maximum: 100 }, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

  before_save :downcase_email

  def downcase_email
    self.email = email.downcase
  end
end
