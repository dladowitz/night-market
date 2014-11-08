class Meal < ActiveRecord::Base
  validates             :category, presence: true
  validates             :event_id, presence: true,     numericality: true
  validates             :guests,   numericality: true, allow_nil: true
  validates_datetime    :start,    allow_nil:    true
  validate              :valid_category?

  belongs_to :event
  has_many   :dishes

  VALID_CATEGORIES = ["Breakfast", "Lunch", "Dinner", "Snack"]

  def has_warnings?
    dishes.each do |dish|
      return true if dish.has_warnings?
    end

    return false
  end

  def show_warning?
    if ignore_warnings?
      false
    else
      has_warnings? ? true : false
    end
  end

  private

  def valid_category?
    unless VALID_CATEGORIES.include? category
      errors.add(:category, "ain't valid dog.")
    end
  end
end
