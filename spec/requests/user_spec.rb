require 'rails_helper'
require 'database_cleaner'

RSpec.describe 'Users', type: :request do
  describe 'Before login while in Homepage' do
    context 'when user clicks on login' do
      it 'opens login page' do
        
      end 
    end

    context 'when user clicks on signup' do
      it 'opens signup page' do
        
      end
    end
  end

  describe 'After login while in profile' do
    context 'when user clicks on edit account' do
      it 'opens edit user page' do
        
      end 
    end

    context 'when user clicks on all projects' do
      it 'opens projects page' do
        
      end 
    end

    context 'when user clicks on all external projects' do
      it 'opens projects page' do
        
      end 
    end

    context 'when user clicks on all external projects' do
      it 'opens projects page' do
        
      end 
    end

  end
end