class Course < ApplicationRecord
  CATEGORIES = %w[typescript react nextjs rails].freeze
  DIFFICULTIES = %w[beginner intermediate advanced].freeze

  has_many :lessons, -> { order(:position) }, dependent: :destroy

  validates :title, presence: true
  validates :category, inclusion: { in: CATEGORIES }
  validates :difficulty, inclusion: { in: DIFFICULTIES }
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :ordered, -> { order(:position) }
  scope :by_category, ->(cat) { cat.present? ? where(category: cat) : all }
  scope :by_difficulty, ->(diff) { diff.present? ? where(difficulty: diff) : all }
end
