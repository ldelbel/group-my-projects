require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe 'Groups', type: :request do
  before do
    DatabaseCleaner.clean
    get '/signup'
    post '/users', params: {
        user: { name: 'Lucas' }
      }
  end

  context 'when user creates new group' do
    it 'creates group and redirect to groups index' do
      get '/groups/new'
      expect(response).to render_template(:new)

      post '/groups', params: { group: { name: 'Ruby on Rails', time_spent: 50 } }
      expect(response).to redirect_to(groups_path)
      follow_redirect!

      expect(response).to render_template(:index)
      expect(response.body).to include("Group was successfully created.")
    end
  end
end