require 'rubygems'
require 'rails_helper'
require 'database_cleaner'
require 'selenium-webdriver'

DatabaseCleaner.strategy = :truncation

RSpec.describe 'Groups', type: :feature do
  before do
    DatabaseCleaner.clean
    visit '/signup'
    fill_in 'user_name', with: 'Lucas'
    click_on 'commit'
    click_on 'All Groups'
  end

  let(:user) do
    User.find_by(name: 'Lucas')
  end

  context 'when user clicks on new group' do
    it 'opens new group page' do
      click_on 'New Group'
      expect(page).to have_content('NEW GROUP')
    end
  end

  context 'when user creates new group' do
    before do
      click_on 'New Group'
      fill_in 'group_name', with: 'Javascript'
      click_on 'commit'
    end

    it 'raises notice' do
      expect(page).to have_content('Group was successfully created.')
    end

    it 'redirects to groups page' do
      expect(page).to have_content('GROUPS')
    end

    it 'shows group in groups page' do
      expect(page).to have_content('Javascript')
    end
  end

  context 'when user deletes group' do
    before do
      click_on 'New Group'
      fill_in 'group_name', with: 'Javascript'
      click_on 'commit'
      click_link('Delete')
    end

    it 'raises notice' do
      expect(page).to have_content('Group was successfully destroyed.')
    end

    it 'erases from groups page' do
      expect(page).not_to have_content('Javascript')
    end
  end
end
