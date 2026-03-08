class Quiz < ApplicationRecord
  QUIZ_TYPES = %w[single_choice multiple_choice true_false fill_in_blank code_challenge].freeze

  belongs_to :lesson
  has_many :quiz_options, -> { order(:position) }, dependent: :destroy
  has_many :user_progresses, dependent: :destroy

  validates :question, presence: true
  validates :quiz_type, inclusion: { in: QUIZ_TYPES }
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :ordered, -> { order(:position) }
end
