require 'rails_helper'
RSpec.describe TasksController, type: :controller do
  describe 'GET index' do
    it 'unauthenticated user not show index page' do
      get :index
      expect(response.status).to eq(302)
    end
    it 'unauthenticated user redirect to sign in' do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
    it 'allow authenticated access user' do
      sign_in_user
      get :index
      expect(response.status).to eq(200)
    end
    it '#all_users_tasks admin has access' do
      sign_in_admin
      get :all_users_tasks
      expect(response.status).to eq(200)
    end
    it '#all_users_tasks user no has access' do
      sign_in_user
      get :all_users_tasks
      expect(response.status).to eq(302)
    end
  end
end
