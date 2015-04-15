require 'rails_helper'

RSpec.describe CardcontrollerController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "renders template index" do
      get :index
      expect(response).to render_template("index")
    end

    it "gives list of cards" do
      get :index
      card = Card.create
      expect(assigns(:cards)).to eq([card])
    end
  end

#  describe "GET #import" do
#    it "returns http success" do
#      get :import
#      expect(response).to have_http_status(:success)
#    end
#  end

end
