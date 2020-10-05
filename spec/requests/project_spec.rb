require 'rails_helper'
require 'database_cleaner'

RSpec.describe 'Projects', type: :request do
  before do
    DatabaseCleaner.clean
    User.create(name: 'Lucas')
    get '/login'
    post '/login', params: {
      session: {
        name: 'Lucas'
      }
    }
  end
  
  context 'when user creates new project' do
    it 'creates project and redirect to project show' do
      get '/projects/new'
      expect(response).to render_template(:new)

      post '/projects', params: { project: { name: 'Project 1', time_spent: 10 } }
      expect(response).to redirect_to(assigns(:project))
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include("Project was successfully created.")
    end
  end
end