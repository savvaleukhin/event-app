require 'rails_helper'

RSpec.describe EventsController, type: :controller do

  let(:valid_attributes) {
    attributes_for(:event)
  }

  let(:invalid_attributes) {
    attributes_for(:invalid_event)
  }

  let(:user) { create(:user) }
  let(:event) { create(:event, user: user) }

  describe "GET #index" do
    let(:events) { create_list(:event_with_user, 2) }

    context 'Authenticated user' do
      before do
        sign_in user
        get :index
      end

      it "assigns all events as @events" do
        expect(assigns(:events)).to match_array(events)
      end

      it 'renders index view' do
        expect(response).to render_template :index
      end
    end

    context 'Non-authenticated user' do
      before { get :index }

      it "does not assign events as @events" do
        expect(assigns(:events)).to_not match_array(events)
      end

      it 'renders index view' do
        expect(response).to render_template :index
      end
    end
  end

  describe "GET #my" do
    let(:events) { create_list(:event, 2, user: user) }
    let(:other_event) { create(:event_with_user) }

    context 'Authenticated user' do
      before do
        sign_in user
        get :my
      end

      it "assigns my events as @events" do
        expect(assigns(:events)).to match_array(events)
      end

      it 'renders my view' do
        expect(response).to render_template :my
      end
    end

    context 'Non-authenticated user' do
      before { get :my }

      it 'redirects to new_registration_path' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET #edit" do
    context 'Authenticated user' do
      before { sign_in user }

      it "assigns the requested event as @event" do
        get :edit, id: event
        expect(assigns(:event)).to eq(event)
      end
    end

    context 'Non-authenticated user' do
      it 'redirects to new_registration_path' do
        get :edit, id: event
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST #create" do
    context 'Authenticated user' do
      before { sign_in user }

      context "with valid params" do
        it "creates a new Event" do
          expect {
            post :create, {:event => valid_attributes}
          }.to change(Event, :count).by(1)
        end

        it "assigns a newly created event as @event" do
          post :create, {:event => valid_attributes}
          expect(assigns(:event)).to be_a(Event)
          expect(assigns(:event)).to be_persisted
        end

        it "redirects to the created event" do
          post :create, {:event => valid_attributes}
          expect(response).to redirect_to events_url
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved event as @event" do
          post :create, {:event => invalid_attributes}
          expect(assigns(:event)).to be_a_new(Event)
        end

        it "re-renders the 'new' template" do
          post :create, {:event => invalid_attributes}
          expect(response).to render_template("new")
        end
      end
    end

    context 'Non-authenticated user' do
      it "does not create a new Event" do
        expect {
          post :create, {:event => valid_attributes}
        }.to_not change(Event, :count)
      end

      it 'redirects to new_registration_path' do
        post :create, {:event => valid_attributes}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "PUT #update" do
    let(:new_attributes) {
      { title: 'Updated title', start_date: '1111-01-01'}
    }

    context 'Authenticated user' do
      before { sign_in user }

      context "with valid params" do
        it "updates the requested event" do
          event
          put :update, {:id => event.to_param, :event => new_attributes}
          event.reload
          expect(event.title).to eq 'Updated title'
          expect(event.start_date.to_s).to eq '1111-01-01'
        end

        it "assigns the requested event as @event" do
          event
          put :update, {:id => event.to_param, :event => valid_attributes}
          expect(assigns(:event)).to eq(event)
        end

        it "redirects to the event" do
          event
          put :update, {:id => event.to_param, :event => valid_attributes}
          expect(response).to redirect_to events_url
        end
      end

      context "with invalid params" do
        it "assigns the event as @event" do
          event
          put :update, {:id => event.to_param, :event => invalid_attributes}
          expect(assigns(:event)).to eq(event)
        end

        it "re-renders the 'edit' template" do
          event
          put :update, {:id => event.to_param, :event => invalid_attributes}
          expect(response).to render_template("edit")
        end
      end
    end

    context 'Non-authenticated user' do
      it "does not the requested event" do
        event
        put :update, {:id => event.to_param, :event => new_attributes}
        event.reload
        expect(event.title).to eq 'MyString'
        expect(event.start_date.to_s).to eq '2015-05-05'
      end

      it 'redirects to new_registration_path' do
        event
        put :update, {:id => event.to_param, :event => invalid_attributes}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "DELETE #destroy" do
    context 'Authenticated user' do
      before { sign_in user }

      it "destroys the requested event" do
        event
        expect {
          delete :destroy, {:id => event.to_param}
        }.to change(Event, :count).by(-1)
      end

      it "redirects to the events list" do
        event
        delete :destroy, {:id => event.to_param}
        expect(response).to redirect_to(events_url)
      end
    end

    context 'Non-authenticated user' do
      it "does not destroy the requested event" do
        event
        expect {
          delete :destroy, {:id => event.to_param}
        }.to_not change(Event, :count)
      end

      it 'redirects to new_registration_path' do
        event
        delete :destroy, {:id => event.to_param}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end
