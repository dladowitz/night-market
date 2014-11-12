# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  guests      :integer          not null
#  user_id     :integer
#  location    :string(255)
#  start_date  :datetime
#  end_date    :datetime
#  budget      :integer
#  gluten_free :boolean
#  vegetarian  :boolean
#  vegan       :boolean
#  dairy_free  :boolean
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
end
