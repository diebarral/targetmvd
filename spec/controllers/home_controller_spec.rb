require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe 'GET #index' do
    login_user

    it 'returns a 200 OK code' do
      get :index
      expect(response).to have_http_status(200)
    end
  end
end
