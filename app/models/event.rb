class Event < ActiveRecord::Base
  validates_presence_of :name, :guests
  validates_numericality_of :guests
  validates_datetime :start_date, :end_date
end
