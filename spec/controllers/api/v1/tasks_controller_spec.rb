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

      context "task not exist" do
        it "returns not found" do 
          get :show, params: { id: 2 }
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    describe "POST #create" do
      before(:each) do
        @task_attributes = attributes_for(:task,user: @current_user)
        post :create, params: {tasks: @task_attributes}
      end

      let(:task_query) { Task.last }

      it "task created" do 
        expect(response).to have_http_status(:created)
      end

      it "task params" do 
        expect(task_query.user).to eql(@current_user)
        expect(task_query.name).to eql(@task_attributes[:name])
        expect(task_query.description).to eql(@task_attributes[:description])
        expect(task_query.status).to eql(@task_attributes[:status])
        expect(task_query.priority.to_sym).to eql(@task_attributes[:priority])
      end
    end

    describe "DELETE #destroy" do
      it "success" do 
        @task = create(:task,user: @current_user)
        delete :destroy ,params: { id: @task.id }
        expect(response).to have_http_status(:success)
      end

      it "not success" do 
        @task = create(:task)
        delete :destroy ,params: { id: @task.id }
        p response.status
        expect(response).to have_http_status(:forbidden)
      end
    end


    describe "POST #update" do
      before(:each) do
        @task = create(:task,user: @current_user)
      end

      it "success" do
        @task_attributes = attributes_for(:task)
        put :update , params: { id: @task.id, tasks: @task_attributes }

        expect(response).to have_http_status(:success)
      end

    end

  end
end
