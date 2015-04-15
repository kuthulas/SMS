require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
 
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
      #student = Student.create
      expect(assigns(:students)).to eq([])
    end
  end

end
