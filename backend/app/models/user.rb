class User < ApplicationRecord
  ROLES = %w[user admin].freeze

  has_secure_password
  has_many :user_progresses, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, inclusion: { in: ROLES }
  validates :password, length: { minimum: 6 }, if: :password_digest_changed?

  before_save { self.email = email.downcase }
end
