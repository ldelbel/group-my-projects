require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe 'Projects', type: :feature do
  before do
    DatabaseCleaner.clean
    visit '/signup'
    fill_in 'user_name', with: 'Lucas'
    click_on 'commit'
    click_on 'All Projects'
  end

  let(:user) {
    User.find_by(name: 'Lucas')
  }

  let(:create_group) {
    visit '/groups'
    click_on 'New Group'
    fill_in 'group_name', with: 'Ruby on Rails'
    click_on 'commit'
    find("a[href='#{user_path(user)}']").click
    click_on 'All Projects'
  }

  let(:group) {
    Group.find_by(name: 'Ruby on Rails')
  }

  context 'when user clicks on create project' do
    it 'opens new project page' do
      click_on 'New Project'
      expect(page).to have_content('NEW PROJECT')
    end
  end

  context 'when user creates project' do
    before do
      create_group
      click_on 'New Project'
      fill_in 'project_name', with: 'DevTracker'
      fill_in 'project_time_spent', with: 15
      check 'group_ids_'
      click_on 'commit'
    end

    it 'raises success notice' do
      expect(page).to have_content('Project was successfully created.')
    end

    it 'redirects to project show' do
      expect(page).to have_content('DEVTRACKER')
    end

    it 'is listed in all projects' do
      find("a[href='#{projects_url}']").click
      expect(page).to have_content('PROJECTS')
      expect(page).to have_content('DevTracker')
    end

    it 'is listed in group#show' do
      visit user_path(user)
      click_on 'All Groups'
      first("a[href='#{group_path(group)}']").click
      expect(page).to have_content('DevTracker')
    end
  end

  context 'when user deletes project' do
    before do
      visit projects_path
      click_on 'New Project'
      fill_in 'project_name', with: 'DevTracker'
      click_on 'commit'
      click_link('Delete')
    end

    it 'raises notice' do
      expect(page).to have_content('Project was successfully destroyed.')
    end

    it 'erases from projects page' do
      expect(page).not_to have_content('DevTracker')
      expect(page).to have_content('PROJECTS')
    end
  end
end