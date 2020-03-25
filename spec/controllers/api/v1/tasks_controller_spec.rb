require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  include Devise::Test::ControllerHelpers

  context "logged in user" do
    before(:each) do 
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @current_user = FactoryBot.create(:user)
      sign_in @current_user
    end
  
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)  
      end
    end

    describe "GET #show" do
      context "task exist" do
        it "returns success" do 
          task = create(:task,user: @current_user)
          get :show, params: { id: task.id }

          expect(response).to have_http_status(:success)
        end
      end
    end

  end
end
