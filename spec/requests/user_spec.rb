require 'rails_helper'
require 'database_cleaner'

RSpec.describe 'Users', type: :request do
  let(:signin) {
    DatabaseCleaner.clean
    User.create(name: 'Lucas')
    get '/login'
    post '/login', params: {
      session: {
        name: 'Lucas'
      }
    }
  }

  describe 'Before login while in Homepage' do
    context 'when user access login page' do
      it 'opens page (ok status)' do
        get '/login'
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user access signup page' do
      it 'opens page (ok status)' do
        get '/signup'
        expect(response).to have_http_status(:ok)
      end
    end
    
    context 'when user tries to access profile page without login' do
      it 'opens login page' do
        get '/users/1'
        expect(response).to redirect_to('/login')
      end
    end
  end

  describe 'After login' do
    before do
      signin
    end

    context 'when user access profile page' do
      it 'opens page (ok status)' do
        get '/users/1'
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user access any link from profile page' do
      it 'opens page (ok status)' do
        get '/users/1/edit'
        expect(response).to have_http_status(:ok)

        get '/projects', params: {type: 0}
        expect(response).to have_http_status(:ok)

        get '/projects', params: {type: 1}
        expect(response).to have_http_status(:ok)
        
        get '/groups'
        expect(response).to have_http_status(:ok)

        delete '/logout'
        expect(response).to redirect_to(root_path)
        follow_redirect!

        expect(response).to have_http_status(:ok)
      end
    end    
  end
end