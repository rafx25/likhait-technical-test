class Expense < ApplicationRecord
  belongs_to :category

  validates :date, presence: true
  validate :date_cannot_be_in_the_future

  private

  # An expense records money already spent, so its date must be today or earlier.
  # This mirrors the client-side guard and protects the API from direct requests.
  def date_cannot_be_in_the_future
    return if date.blank?

    if date > Date.current
      errors.add(:date, "can't be in the future")
    end
  end
end
