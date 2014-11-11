require 'rails_helper'

describe SessionsController do
  describe "GET new" do
    subject { get :new }
    before  { subject }

    context "without an authenticated user" do
      it "renders the new template" do
        expect(response).to render_template :new
      end

      it "returns http 200 success" do
        expect(response.status).to eq 200
      end
    end

    context "with an authenticated user" do
      skip "redirects to the events page" do
        expect(response).to redirect_to events_path
      end
    end
  end

  describe "POST create" do
    let(:user) { create :user }
    subject { post :create, params }
    before  { subject }

    context "with correct email and password" do
      let(:params) { { user: {email_address: user.email_address, password: "asdfasdf"} } }

      it "finds the correct user in the database" do
        expect(assigns(:user)).to eq user
      end

      it "sets the session correctly" do
        expect(session[:user_id]).to eq user.id
      end

      it "sets the flash correctly" do
        expect(flash[:success]).to eq "You did it. Login success!"
      end

      it "redirects to the events page" do
        expect(response).to redirect_to events_path
      end

      it "returns http 302 redirect" do #TODO this is probably the same as the previous test
        expect(response.status).to eq 302
      end

    end

    context "when email is not found in database" do
      let(:params) { { user: {email_address: "bad_email@gmail.com", password: "asdfasdf"} } }

      it "assigns @user to nil" do
        expect(assigns(:user)).to be_nil
      end

      it "does not set the session" do
        expect(session[:user_id]).to be_nil
      end

      it "sets flash[:danger]" do
        expect(flash[:danger]).to eq "This is not the email address you are looking for."
      end

      it "renders the new templare" do
        expect(response).to render_template :new
      end
    end

    context "when password isn't correct" do
      let(:params) { { user: {email_address: user.email_address, password: "bad password"} } }
    end
  end
end
