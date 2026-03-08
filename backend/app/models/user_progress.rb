class UserProgress < ApplicationRecord
  STATUSES = %w[not_started in_progress completed].freeze

  belongs_to :user
  belongs_to :lesson, optional: true
  belongs_to :quiz, optional: true

  validates :status, inclusion: { in: STATUSES }
end
