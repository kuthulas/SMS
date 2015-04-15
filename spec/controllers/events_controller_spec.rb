require 'rails_helper'

RSpec.describe EventsController, type: :controller do
 
  include Devise::TestHelpers 
  describe "GET #index" do
    it "returns http success" do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in FactoryGirl.create(:admin)
      get :index
      expect(response).to have_http_status(:success)
    end

    it "renders template index" do
      get :index
      expect(response).to render_template(:index)
    end

    it "gives list of events" do
      get :index
      #event = Event.create
      expect(assigns(:events)).to eq([])
    end
  end

  describe "GET #check" do
    it "shows a checkin" do
      event = Event.create
      checkin = Checkin.create
      checkin.event_id = event.id
      get :check, id: event.id
      expect(assigns(:checkins)).to eq([checkin])
    end
  end

end
