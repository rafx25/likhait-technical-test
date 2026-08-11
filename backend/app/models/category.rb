class Category < ApplicationRecord
  has_many :expenses, dependent: :destroy

  # A category name is required, capped to the column limit, and must be unique.
  # Uniqueness is validated case-insensitively so "Food" and "food" are treated
  # as the same category (this also matches the case-insensitive DB collation).
  validates :name, presence: true,
                   length: { maximum: 100 },
                   uniqueness: { case_sensitive: false }

  # Normalize surrounding whitespace so " Food " and "Food" don't slip through.
  normalizes :name, with: ->(name) { name.strip }
end
