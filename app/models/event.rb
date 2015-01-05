# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  guests      :integer          not null
#  user_id     :integer
#  location    :string(255)
#  start_date  :date
#  end_date    :date
#  budget      :integer
#  gluten_free :boolean
#  vegetarian  :boolean
#  vegan       :boolean
#  created_at  :datetime
#  updated_at  :datetime
#

class Event < ActiveRecord::Base
  #TODO should move boolean options like vegan and needs_ice out to something else

  validates           :name,       presence: true
  validates           :guests,     presence: true, numericality: true
  validates           :user_id,    presence: true, numericality: true
  validates_datetime  :start_date, :end_date #TODO change these to start and end

  belongs_to :user
  has_many :meals
  has_many :supplies

  def overbudget?
    current_spend > budget if current_spend && budget
  end

  def current_spend
    total = meals_cost + supplies_cost
  end

  def show_warnings?
    meals.each do |meal|
      return true if meal.warning_messages.present? && !meal.ignore_warnings
    end

    return false
  end

  def missing_supplies
    supplies.where("purchased = ? OR purchased = ?", false, nil)
  end

  private

  def meals_cost
    total = 0

    meals.each do |meal|
      total += meal.cost if meal.cost
    end

    total || 0
  end

  def supplies_cost
    total = 0

    supplies.each do |supply|
      total += supply.cost if supply.cost
    end

    total || 0
  end

end
