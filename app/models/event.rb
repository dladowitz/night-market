class Event < ActiveRecord::Base
  #TODO should move boolean options like vegan and needs_ice out to something else

  validates           :name,   presence: true
  validates           :guests, presence: true, numericality: true
  validates_datetime  :start_date, :end_date #TODO change these to start and end

  has_many :meals
end
