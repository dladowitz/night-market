require 'rails_helper'

describe UsersController do
  describe "GET new" do
    subject { get :new }
    before { subject }

    it "should render the new template" do
      expect(response).to render_template :new
    end

    it "should build a new user" do
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe "POST create" do
    subject { post :create, params }

    context "with valid params" do
      let(:params) { { user: { email_address: "jpinkman@gmail.com", password: "asdfasdf" } } }

      it "creates a new user in the database" do
        expect{ subject }.to change{ User.count }.by 1
      end

      it "redirects to the events page" do
        subject
        expect(response).to redirect_to events_path
      end
    end

    context "with invalid params" do
      let(:params) { { email_address: nil, password: nil } }

      it "doesn't create a new user in the database" do
        expect{ subject }.to_not change{ User.count }
      end

      it "renders the new page" do
        subject
        expect(response).to render_template :new
      end
    end
  end
end
