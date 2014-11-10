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

      it "has a valid factory" do
        expect{ create :user }.to change{ User.count }.by 1
      end

      it "redirects to the events page" do
        subject
        expect(response).to redirect_to events_path
      end
    end

    context "with invalid params" do
      let(:params) { { user: { email_address: nil, password: nil } } }

      it "doesn't create a new user in the database" do
        expect{ subject }.to_not change{ User.count }
      end

      it "renders the new page" do
        subject
        expect(response).to render_template :new
      end
    end
  end

  describe "GET show" do
    let(:user) { create :user }

    subject { get :show, id: user_id }
    before  { subject }

    context "when the user is found in the database" do
      let(:user_id) { user.id }

      it "finds the correct user" do
        expect(assigns(:user)).to eq user
      end

      it "renders the show template" do
        expect(response).to render_template :show
      end
    end

    context "when the user is not found in the database" do
      let(:user_id) { "Not a real ID" }

      it "does not find any users" do
        expect(assigns(:user)).to be_nil
      end

      skip "redirects to the home page" do
        # need to add an unauthorized guest page
      end
    end
   end
end
