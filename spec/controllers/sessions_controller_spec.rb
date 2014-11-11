require 'rails_helper'

describe SessionsController do
  let(:user) { create :user }

  describe "GET new" do
    subject { get :new }

    context "without an authenticated user" do
      it "renders the new template" do
        subject
        expect(response).to render_template :new
      end

      it "returns http 200 success" do
        expect(response.status).to eq 200
      end
    end

    context "with an authenticated user" do
      before { session[:user_id] = user.id }

      it "redirects to the events page" do
        subject
        expect(response).to redirect_to events_path
      end
    end
  end

  describe "POST create" do
    subject { post :create, params }
    before  { subject }

    context "with correct email and password" do
      let(:params) { {email_address: user.email_address, password: "asdfasdf"} }

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
      let(:params) { {email_address: "bad_email@gmail.com", password: "asdfasdf"} }

      it "assigns @user to nil" do
        expect(assigns(:user)).to be_nil
      end

      it "does not set the session" do
        expect(session[:user_id]).to be_nil
      end

      it "sets flash[:danger]" do
        expect(flash[:danger]).to eq "This is not the email address you are looking for."
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end
    end

    context "when password isn't correct" do
      let(:params) { {email_address: user.email_address, password: "bad password"} }

      it "finds the correct user in the database" do
        expect(assigns(:user)).to eq user
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end

      it "sets the flash" do
        expect(flash[:danger]).to eq "That's not your password yo."
      end

      it "does not set the session" do
        expect(session[:user_id]).to be_nil
      end
    end
  end

  describe "GET destroy" do #used for signing out via url instead of a link or button {DELETE destroy}
    subject { get :destroy }

    context "with a logged in user" do
      before :each do
        session[:user_id] = user.id
        subject
      end

      it "logs the user out" do
        expect(session[:user_id]).to be_nil
      end

      it "sets the flash" do
        expect(flash[:success]).to eq "Bye Bye. Have fun storming the castle!"
      end

      it "redirects to the sign in page" do
        expect(response).to redirect_to signin_path #TODO create signin_path
      end
    end

    context "without a logged in user" do
      before { subject }

      it "redirects to the sign in page" do
        expect(response).to redirect_to signin_path #TODO create signin_path
      end

      it "sets the flash" do
        expect(flash[:danger]).to eq "Errr, you can't log out when you aren't logged in. That's science."
      end
    end
  end
end
