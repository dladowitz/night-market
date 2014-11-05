class Meal < ActiveRecord::Base
  validates_presence_of :category
  validates             :guests, numericality: true, allow_nil: true
  validates_datetime    :start,  allow_nil:    true
  validate              :valid_category?

  belongs_to :event

  private

  def valid_category?
    valid_categories = ["Breakfast", "Lunch", "Dinner", "Snack"]

    unless valid_categories.include? category
      errors.add(:category, "ain't valid dog.")
    end
  end
end
