# == Schema Information
#
# Table name: dishes
#
#  id               :integer          not null, primary key
#  name             :string(255)      not null
#  meal_id          :integer          not null
#  vendor           :string(255)
#  servings         :integer
#  category         :string(255)
#  needs_ordering   :boolean
#  ordered          :boolean
#  vegetarian       :boolean
#  vegan            :boolean
#  gluten_free      :boolean
#  needs_ice        :boolean
#  ignore_warnings  :boolean
#  transport_method :string(255)
#  transport_time   :datetime
#  created_at       :datetime
#  updated_at       :datetime
#

class Dish < ActiveRecord::Base
  #TODO should move boolean options like vegan and needs_ice out to something else

  validates :category,                presence: true
  validates :meal_id,                 numericality: true, presence: true
  validates :name,                    presence: true
  validates :servings,                numericality: true, allow_nil: true
  validate  :valid_transport_method?, allow_nil: true
  validate  :valid_category?

  belongs_to :meal

  VALID_CATEGORIES =        ["Main", "Desert", "Drinks", "Side1", "Side2", "Side3"]
  VALID_TRANSPORT_METHODS = ["Delivery", "Pickup"]

  def warning_messages
    warning_messages = []

    warning_messages << { warning_type: name, message: order_status } if order_warning?
    warning_messages << { warning_type: name, message: "No Delivery Time Set" } if transport_warning?
    warning_messages << { warning_type: name, message: "Not Enough Servings" } if servings_warning?

    return warning_messages
  end

  def has_warnings?
    return true if order_warning?
    return true if servings_warning?
    return true if transport_warning?
    # create methods for anything that causes a warning
    # iterate over those methods

    # 4. no vegi or gluten free if event requires
    # 5. no ice for soda

    return false
  end

  def order_status
    if needs_ordering && !ordered
      "Needs to be Ordered"
    elsif needs_ordering
      "Already Ordered"
    else
      "Doesn't Require Ordering"
    end
  end

  def order_warning?
    if needs_ordering && !ordered
      true
    else
      false
    end
  end

  def transport_warning?
    if transport_method == "Delivery"
      transport_time.present? ? false : true
    else
      false
    end
  end

  def servings_warning?
    same_category_dishes = self.meal.dishes.where(category: category)

    servings_in_category = same_category_dishes.inject(0) { |sum, dish| sum + dish.servings }

    servings_in_category < meal.guests ? true : false
  end

  private

  def valid_category?
    unless VALID_CATEGORIES.include? category
      errors.add(:category, "is not valid yo.")
    end
  end

  def valid_transport_method?
    return unless transport_method

    unless VALID_TRANSPORT_METHODS.include? transport_method
      errors.add(:transport_method, "is not supported. Try: #{VALID_TRANSPORT_METHODS}")
    end
  end
end
