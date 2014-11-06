class Dish < ActiveRecord::Base
  #TODO should move boolean options like vegan and needs_ice out to something else

  validates :name,     presence: true
  validates :category, presence: true
  validates :meal_id,  numericality: true, presence: true
  validates :servings, numericality: true, allow_nil: true
  validate  :valid_category?

  belongs_to :meal

  VALID_CATEGORIES = ["Main", "Desert", "Side1", "Side2", "Side3"]

  private

  def valid_category?
    unless VALID_CATEGORIES.include? category
      errors.add(:category, "is not valid yo.")
    end
  end
end
