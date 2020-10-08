require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe 'Users', type: :feature do
  before do
    DatabaseCleaner.clean
    User.create(name: 'Lucas')
  end

  let(:signup_lucas) do
    visit '/signup'
    fill_in 'user_name', with: 'Lucas'
    click_on 'commit'
  end
  let(:signup_delbel) do
    visit '/signup'
    fill_in 'user_name', with: 'Delbel'
    click_on 'commit'
  end
  let(:signup_short) do
    visit '/signup'
    fill_in 'user_name', with: 'De'
    click_on 'commit'
  end
  let(:signin_lucas) do
    visit '/login'
    fill_in 'session_name', with: 'Lucas'
    click_on 'commit'
  end
  let(:user) do
    User.find_by(name: 'Lucas')
  end

  describe 'Sign Up' do
    context 'when user add valid input' do
      it 'logs in successfully' do
        signup_delbel
        expect(page).to have_content('User was successfully created.')
      end
    end

    context 'when user add existing name' do
      it 'raises error' do
        signup_lucas
        expect(page).to have_content('Name has already been taken')
      end
    end

    context 'when user add an input too short' do
      it 'raises error' do
        signup_short
        expect(page).to have_content('Name is too short')
      end
    end
  end

  describe 'Sign In' do
    context 'when user logs in with valid username' do
      it 'logs in and redirects to profile' do
        signin_lucas
        expect(page).to have_content('Lucas')
        expect(page).to have_content('Edit account')
      end
    end

    context 'when user logs in with non-existent username' do
      it 'raises notice' do
        DatabaseCleaner.clean
        signin_lucas
        expect(page).to have_content('This user doesn\'t exist.')
      end
    end

    context 'when user logs in with blank name' do
      it 'raises notice' do
        DatabaseCleaner.clean
        visit '/login'
        click_on 'commit'
        expect(page).to have_content('Insert a name to log in.')
      end
    end
  end

  describe 'Profile' do
    context 'when user clicks on each link' do
      it 'opens respective page' do
        DatabaseCleaner.clean
        signup_lucas

        click_on 'Edit account'
        expect(page).to have_content('EDIT USER')
        find("a[href='#{user_path(user)}']").click

        click_on 'All Projects'
        expect(page).to have_content('PROJECTS')
        find("a[href='#{user_path(user)}']").click

        click_on 'All External Projects'
        expect(page).to have_content('PROJECTS')
        find("a[href='#{user_path(user)}']").click

        click_on 'All Groups'
        expect(page).to have_content('GROUPS')
        find("a[href='#{user_path(user)}']").click

        click_on 'Log out'
        expect(page).to have_content('LOG IN')
      end
    end
  end
end
