require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:category) { Category.create!(name: "Food") }

  def build_expense(date:)
    Expense.new(description: "Test", amount: 10.0, category: category, date: date)
  end

  it "is valid with today's date" do
    expect(build_expense(date: Date.current)).to be_valid
  end

  it "is valid with a past date" do
    expect(build_expense(date: 3.days.ago.to_date)).to be_valid
  end

  it "is invalid with a future date" do
    expense = build_expense(date: Date.tomorrow)
    expect(expense).not_to be_valid
    expect(expense.errors[:date]).to be_present
  end

  it "is invalid without a date" do
    expense = build_expense(date: nil)
    expect(expense).not_to be_valid
  end
end
