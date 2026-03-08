class QuizOption < ApplicationRecord
  belongs_to :quiz

  validates :body, presence: true
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :ordered, -> { order(:position) }
end
