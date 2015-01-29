# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  email_address   :string(255)
#  password_digest :string(255)
#  admin           :boolean
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :email_address,   presence: true, uniqueness: true
  validates :password,        presence: { on: create }, length: { minimum: 6 }, if: :password_digest_changed?
  validates :password_digest, presence: true

  before_validation :downcase_email_address, :if => Proc.new {|user| user.new_record? }

  has_many :events

  has_secure_password

  #TODO look at making this a decorator or helper
  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def downcase_email_address
    if self.email_address
      self.email_address = self.email_address.downcase
    end
  end
end
