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

  def show_warning?(warning_type = nil)
    return false if ignore_warnings?

    if warning_type
      option_warning?(warning_type)
    else
      has_warnings? ? true : false
    end

    # case warning_type
    # when :gluten_free
    #   gluten_free_warning?
    # when :vegetarian
    #   vegetarian_warning?
    # when :vegan
    #   vegan_warning?
    # when nil
    #   has_warnings? ? true : false
    # end
  end

  # def missing_options
  #   #TODO refactor
  #
  #   event_options = []
  #   event_options << "Gluten-Free" if event.gluten_free
  #   event_options << "Vegetarian"  if event.gluten_free
  #   event_options << "Vegan"       if event.vegan
  #
  #   meal_options =  []
  #   dishes.each do |dish|
  #     meal_options << "Gluten-Free" if dish.gluten_free
  #     meal_options << "Vegetarian"  if dish.vegetarian
  #     meal_options << "Vegan"       if dish.vegan
  #   end
  #
  #   meal_options.uniq!
  #
  #   missing_options = []
  #
  #   event_options.each { |option| missing_options << option unless meal_options.include?(option) }
  #   missing_options
  # end

  private

  # def gluten_free_warning?
  #   self.event.gluten_free? && !dishes_include_option?(:gluten_free)
  # end

  def option_warning?(option_type)
    # checks if event require option type and none of the dishes include this type
    self.event.send(option_type) && !dishes_include_option?(option_type)
  end

  def dishes_include_option?(option_type)
    self.dishes.each do |dish|
      return true if dish.send(option_type) #calling option_type as a attribute
    end

    false
  end

  def valid_category?
    unless VALID_CATEGORIES.include? category
      errors.add(:category, "ain't valid dog.")
    end
  end
end
