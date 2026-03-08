class Lesson < ApplicationRecord
  belongs_to :course
  has_many :quizzes, -> { order(:position) }, dependent: :destroy
  has_many :user_progresses, dependent: :destroy

  validates :title, presence: true
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :ordered, -> { order(:position) }
end
