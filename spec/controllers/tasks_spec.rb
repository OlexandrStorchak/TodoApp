require 'rails_helper'
RSpec.describe TasksController, type: :controller do
  describe 'GET index' do
    it 'blocks unauthenticated access' do
      sign_in nil
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
