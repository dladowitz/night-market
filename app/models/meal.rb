# == Schema Information
#
# Table name: meals
#
#  id              :integer          not null, primary key
#  category        :string(255)      not null
#  event_id        :integer          not null
#  cost            :integer
#  guests          :integer
#  start           :datetime
#  ignore_warnings :boolean
#  created_at      :datetime
#  updated_at      :datetime
#

class Meal < ActiveRecord::Base
  validates             :category, presence: true
  validates             :event_id, presence: true,     numericality: true
  validates             :guests,   numericality: true, allow_nil: true
  # validates_datetime    :start,    allow_nil:    true
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

  def missing_options
    #TODO refactor

    event_options = []
    event_options << "Gluten-Free" if event.gluten_free
    event_options << "Vegetarian"  if event.gluten_free
    event_options << "Vegan"       if event.vegan

    meal_options =  []
    dishes.each do |dish|
      meal_options << "Gluten-Free" if dish.gluten_free
      meal_options << "Vegetarian"  if dish.vegetarian
      meal_options << "Vegan"       if dish.vegan
    end

    meal_options.uniq!

    missing_options = []

    event_options.each { |option| missing_options << option unless meal_options.include?(option) }
    missing_options
  end

  private

  def valid_category?
    unless VALID_CATEGORIES.include? category
      errors.add(:category, "ain't valid dog.")
    end
  end
end
