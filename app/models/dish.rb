class Dish < ActiveRecord::Base
  #TODO should move boolean options like vegan and needs_ice out to something else

  validates :name,     presence: true
  validates :category, presence: true
  validates :meal_id,  numericality: true, presence: true
  validates :servings, numericality: true, allow_nil: true
  validate  :valid_category?
  validate  :valid_transport_method?, allow_nil: true

  belongs_to :meal

  VALID_CATEGORIES = ["Main", "Desert", "Side1", "Side2", "Side3"]
  VALID_TRANSPORT_METHODS = ["Delivery", "Pickup"]

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
