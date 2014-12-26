require 'rails_helper'

describe EventsController do
  let(:user1)  { create :user }
  let(:event1) { create :event, user_id: user1.id }
  let(:user2)  { create :user }
  let(:event2) { create :event, user_id: user2.id }

  describe "GET index" do
    subject { get :index }

    context "with a logged in user" do
      before :each do
        login_user(user1)
        subject
      end

      it "renders the index template" do
        expect(response).to render_template :index
      end

      it "finds only the users events" do
        expect(assigns(:events)).to match_array [event1]
      end

      it "does not find other users events" do
        expect(assigns(:events)).to_not include event2
      end

      it "shows them chronological order by start date" do
        # TODO not sure how to check order of elements in an array
      end
    end

    context "without a logged in user" do
      it_behaves_like "an_unauthenticated_user" do
        let(:http_request) { subject }
      end
    end
  end

  describe "GET new" do
    subject { get :new }

    context "with a logged in user" do
      before :each do
        login_user
        subject
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end

      it "creates a blank event" do
        expect(assigns(:event)).to be_a Event
      end
    end

    context "without a logged in user" do
      it_behaves_like "an_unauthenticated_user" do
        let(:http_request) { subject }
      end
    end
  end

  describe "POST create" do
    subject { post :create, event: params }

    context "with a logged in user" do
      before { login_user(user1) }

      context "with valid params" do
        let(:params ){ { name: "Startup Weekend Oakland", guests: 55, start_date: 3.days.from_now, end_date: 5.days.from_now } }

        it "should create a new object in the database" do
          expect { subject }.to change{Event.count}.by 1
        end

        it "should create an event belonging to the logged in user" do
          expect{ subject }.to change{ user1.events.count }.by 1
        end

        context "when the 'auto_populate' checkbox is checked" do
          subject { post :create, auto_populate: "yes", event: params}

          it "should create seven meals" do
            expect{ subject }.to change{ Meal.count }.by 7
          end
        end
      end

      context "with invalid params" do
        context "without required params" do
          let(:params ) { { name: nil } }

          it "does not create a new object in the database" do
            expect { subject }.to_not change{Event.count}
          end

          it "renders the new template" do
            subject
            expect(response).to render_template :new
          end
        end

        context "with bad data types" do
          context "when guests is not a number" do
            let(:params) { { name: "Startup Weekend Oakland", guests: "Many" } }

            it "does not create a new object in the database" do
              expect { subject }.to_not change{Event.count}
            end
          end

          context "when start_date is not a datetime" do
            let(:params) { { name: "Startup Weekend Oakland", guests: 100, start_date: "Sometime" } }

            it "does not create a new object in the database" do
              expect { subject }.to_not change{Event.count}
            end
          end
        end
      end
    end

    context "without a logged in user" do
      it_behaves_like "an_unauthenticated_user" do
        let(:params ) { { name: "Startup Weekend Oakland", guests: 55, start_date: 3.days.from_now, end_date: 5.days.from_now } }
        let(:http_request) { subject }
      end
    end
  end

  describe "GET show" do
    subject { get :show, id: event_id }

    context "with a logged in user" do
      before :each do
        login_user(user1)
        subject
      end

      context "when event is in the database" do
        let(:event_id) { event1.id }

        it "finds the correct event" do
          expect(assigns(:event)).to eq event1
        end

        context "when events do not belong to the user" do
          let(:event_id) { event2.id }

          it "does not show other users events" do
            expect(response).to redirect_to home_path
          end

          it "sets the flash" do
            expect(flash[:danger]).to eq "Access Denied. All your bases are belong to us."
          end
        end
      end

      context "when the event is not in the database" do
        let(:event_id) { "Not an ID" }

        it "does not find the event" do
          expect(assigns(:event)).to be_nil
        end

        it "redirects to the index page" do
          expect(response).to redirect_to home_path
        end

        it "sets a flash message" do
          expect(flash[:danger]).to eq "That's not a thing in the database"
        end
      end
    end

    context "without a logged in user" do
      it_behaves_like "an_unauthenticated_user" do
        let(:event_id) { "any" }
        let(:http_request) { subject }
      end
    end
  end

  describe "GET edit" do
    subject { get :edit, id: event_id }

    context "with a logged in user" do
      before :each do
        login_user(user1)
        subject
      end

      context "when event is in the database" do
        let(:event_id) { event1.id }

        it "renders the edit template" do
          expect(response).to render_template :edit
        end

        it "finds the event" do
          expect(assigns(:event)).to eq event1
        end
      end

      context "when the event is not in the database" do
        let(:event_id) { "Not a real ID"}

        it "does not find the event" do
          expect(assigns(:event)).to eq nil
        end

        it "redirects to the index page" do
          expect(response).to redirect_to home_path
        end

        it "sets a flash message" do
          expect(flash[:danger]).to eq "That's not a thing in the database"
        end
      end
    end

    context "without a logged in user" do
      it_behaves_like "an_unauthenticated_user" do
        let(:event_id) { 1 }
        let(:http_request) { subject }
      end
    end
  end

  describe "PATCH update" do
    subject { patch :update, id: event_id, event: params }

    context "with a logged in user" do
      before { login_user(user1) }

      context "when the event is in the database" do
        let(:event_id ) { event1.id }

        context "with valid params" do
          let(:params) { { name: "Startup Weekend Boston", guests: 200 } }

          it "updates the event" do
            subject
            expect(event1.reload.name).to eq "Startup Weekend Boston"
          end
        end

        context "with invalid params" do
          context "with missing required params" do
            let(:params) { { name: nil } }

            it "does not update the event" do
              subject
              expect(event1.reload.name).to eq "Startup Weekend San Francisco"
            end

            it "renders the edit template" do
              subject
              expect(response).to render_template :edit
            end
          end

          context "with bad datatypes" do
            let(:original_start_date) { event1.start_date}
            let(:params) { { start_date: "Not a datetime object" } }

            it "does not update the event" do
              subject
              expect(event1.reload.start_date).to eq  original_start_date
            end
          end
        end
      end

      context "when the event is not in the database" do
        let(:event_id) { "Not a real ID" }
        let(:params) { { name: "Startup Weekend Boston", guests: 200 } }

        it "does not find the event" do
          subject
          expect(assigns(:event)).to be_nil
        end

        it "redirect to the index page" do
          subject
          expect(response).to redirect_to home_path
        end

        it "set a flash message" do
          subject
          expect(flash[:danger]).to eq "That's not a thing in the database"
        end
      end
    end

    context "without a logged in user" do
      it_behaves_like "an_unauthenticated_user" do
        let(:event_id) { 1 }
        let(:params) { { name: "Startup Weekend Boston", guests: 200 } }
        let(:http_request) { subject }
      end
    end
  end

  describe "DELETE destroy" do
    subject { delete :destroy, id: event_id }

    context "with a logged user" do
      before { login_user(user1) }

      context "when the event is in the database" do
        let!(:event_id) { event1.id }

        it "deleted the event from the database" do
          expect { subject }.to change{Event.count}.by -1
        end
      end

      context "when the event is not in the database" do
        let(:event_id) { "Not a real Id" }

        it "does not delete anything from the database" do
          expect { subject }.to_not change{Event.count}
        end

        it "redirects to the index page" do
          subject
          expect(response).to redirect_to home_path
        end

        it "sets a flash message" do
          subject
          expect(flash[:danger]).to eq "That's not a thing in the database"
        end
      end
    end

    context "without a logged in user" do
      it_behaves_like "an_unauthenticated_user" do
        let(:event_id) { 1 }
        let(:http_request) { subject }
      end
    end
  end
end
