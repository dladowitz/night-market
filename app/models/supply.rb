# == Schema Information
#
# Table name: supplies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  event_id   :integer
#  purchased  :boolean
#  vendor     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Supply < ActiveRecord::Base
  validates :event_id,  presence: true, numericality: true
  validates :name,      presence: true

  belongs_to :event
end
