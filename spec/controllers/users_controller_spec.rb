require 'rails_helper'

describe UsersController do
  let(:user) { create :user }

  describe "GET index" do
    let(:user1) { create :user }
    let(:user2) { create :user }
    subject { get :index }

    it_behaves_like "an_unauthenticated_user" do
      let(:http_request) { subject }
    end

    context "with a logged in user" do
      context "with an admin user" do
        let(:admin) { create :user, admin: true }
        before { login_user(admin) && subject }

        it "finds all users" do
          expect(assigns[:users]).to match_array [user, user1, user2, admin]
        end

        it "renders the index template" do
          expect(response).to render_template :index
        end
      end

      context "with a non-admin user" do
        before  { login_user(user) && subject }

        it "finds no users users" do
          expect(assigns[:users]).to be_empty
        end

        it "redirects to hoe page" do
          expect(response).to redirect_to home_path
        end
      end
    end
  end

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
      let(:params) { { user: { email_address: "jpinkman@gmail.com", password: "asdfasdf", password_confirmation: "asdfasdf" } } }

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

    context "with INVALID params" do
      context "with missing email_address" do
        let(:params) { { user: { email_address: nil, password: "asdfasdf", password_confirmation: "asdfasdf" } } }

        it "doesn't create a new user in the database" do
          expect{ subject }.to_not change{ User.count }
        end

        it "renders the new page" do
          subject
          expect(response).to render_template :new
        end
      end

      context "when passwords don't match" do
        let(:params) { { user: { email_address: "volta@gmail.com", password: "asdfasdf", password_confirmation: "12345678" } } }

        it "doesn't create a new user in the database" do
          expect{ subject }.to_not change{ User.count }
        end

        it "renders the new page" do
          subject
          expect(response).to render_template :new
        end
      end

      context "with email_address is not unique" do
        before { @other_user = create :user }

        let(:params) { { user: { email_address: @other_user.email_address, password: "asdfasdf", password_confirmation: "asdfasdf" } } }

        it "doesn't create a new user in the database" do
          expect{ subject }.to_not change{ User.count }
        end

        context "when uses duplicate email address that with uppercase chars" do
          let(:params) { { user: { email_address: @other_user.email_address.upcase, password: "asdfasdf", password_confirmation: "asdfasdf" } } }

          it "doesn't create a new user in the database" do
            expect{ subject }.to_not change{ User.count }
          end
        end
      end
    end
  end

  describe "GET show" do
    subject { get :show, id: user_id }

    it_behaves_like "an_unauthenticated_user" do
      let(:user_id) { user.id }
      let(:http_request) { subject }
    end

    context "with a logged in user" do
      before  { login_user(user) && subject }

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

        it "redirects to the index page" do
          expect(response).to redirect_to home_path
        end
      end
    end
  end
end
