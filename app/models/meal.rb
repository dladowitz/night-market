class Meal < ActiveRecord::Base
  validates             :category, presence: true
  validates             :event_id, presence: true,     numericality: true
  validates             :guests,   numericality: true, allow_nil: true
  validates_datetime    :start,    allow_nil:    true
  validate              :valid_category?

  belongs_to :event
  has_many   :dishes

  VALID_CATEGORIES = ["Breakfast", "Lunch", "Dinner", "Snack"]

  private

  def valid_category?
    unless VALID_CATEGORIES.include? category
      errors.add(:category, "ain't valid dog.")
    end
  end
end
