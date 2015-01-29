require 'rails_helper'

describe User do
  it { should have_many :events }
  it { should validate_presence_of :email_address }
  it { should validate_uniqueness_of :email_address }
  it { should validate_presence_of :password_digest }

  describe "#full_name" do
    let(:user) { create :user, first_name: "Gus", last_name: "Fring" }

    it "concatanates first and last name" do
      expect(user.full_name).to eq "Gus Fring"
    end

    context "when email address is entered with uppercase letters" do
      let(:upcase_user) { create :user, email_address: "GusFring@gmail.com", first_name: "Gus", last_name: "Fring" }

      it "downcases all email addresses" do
        expect(upcase_user.email_address).to eq "gusfring@gmail.com"
      end
    end
  end
end
