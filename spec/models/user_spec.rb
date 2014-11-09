require 'rails_helper'

describe User do
  it { should have_many :events }
  it { should validate_presence_of :email_address }
  it { should validate_uniqueness_of :email_address }
  it { should validate_presence_of :password_digest }
end
