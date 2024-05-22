require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create(name: "Caesar", email: 'brutus#1fan@email.com', password: "password123")

    visit root_path

    click_on "Log In"

    expect(current_path).to eq(login_path)

    within '.login_form' do
      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Log In"
    end

    expect(current_path).to eq(user_path(user))

    expect(page).to have_content("Welcome, #{user.name}")
  end

  it "cannot log in with bad credentials" do
    user = User.create(name: "Caesar", email: 'brutus#1fan@email.com', password: "password123")

    visit root_path

    click_on "Log In"

    expect(current_path).to eq(login_path)

    within '.login_form' do
      fill_in :email, with: user.email
      fill_in :password, with: 'wrong password'

      click_on "Log In"
    end

    expect(current_path).to eq(login_path)

    expect(page).to have_content("Invalid email address or password.")
  end

  describe 'log out' do
    it 'can log out once you are logged in and returns you to the root page' do
      user = User.create(name: "Caesar", email: 'brutus#1fan@email.com', password: "password123")

      visit root_path

      expect(page).to_not have_button('Log Out')

      click_on "Log In"

      expect(current_path).to eq(login_path)

      within '.login_form' do
        fill_in :email, with: user.email
        fill_in :password, with: user.password

        click_on "Log In"
      end

      click_on 'Log Out'

      expect(page).to have_content('Logged out successfully.')
      expect(current_path).to eq(root_path)
    end

    it 'does not have show the log in or register links when logged in and when you log out, it shows them again' do
      user = User.create(name: "Caesar", email: 'brutus#1fan@email.com', password: "password123")

      visit root_path

      click_on "Log In"

      within '.login_form' do
        fill_in :email, with: user.email
        fill_in :password, with: user.password

        click_on "Log In"
      end

      expect(page).to_not have_link('Log In')
      expect(page).to_not have_link('Register')

      click_on "Log Out"

      expect(page).to have_link('Log In')
      expect(page).to have_link('Register')
    end
  end

  describe 'remember me cookie' do
    it 'remembers that you are logged in even when you navigate to a different website' do
      user = User.create(name: "Caesar", email: 'brutus#1fan@email.com', password: "password123")

      visit root_path

      click_on "Log In"

      within '.login_form' do
        fill_in :email, with: user.email
        fill_in :password, with: user.password

        click_on "Log In"
      end

      visit "http://google.com"

      visit root_path

      expect(page).to have_button('Log Out')
    end
  end

  describe 'location cookie' do
    it 'has a field to enter your location that is stored within a cookie and your location will be visible on the landing page' do
      user = User.create(name: 'Caesar', email: 'brutus#1fan@email.com', password: 'password123')

      visit root_path

      click_on 'Log In'

      expect(current_path).to eq(login_path)

      within '.login_form' do
        fill_in :email, with: user.email
        fill_in :password, with: user.password
        fill_in :location, with: 'the jungle'

        click_on "Log In"
      end

      expect(current_path).to eq(user_path(user))

      expect(page).to have_content('Location: the jungle')
    end

    it 'when you log out and click log in again, the location field will already be filled out with your previously entered location' do
      user = User.create(name: 'Caesar', email: 'brutus#1fan@email.com', password: 'password123')

      visit root_path

      click_on 'Log In'

      expect(current_path).to eq(login_path)

      within '.login_form' do
        fill_in :email, with: user.email
        fill_in :password, with: user.password
        fill_in :location, with: 'the jungle'

        click_on "Log In"
      end

      expect(page).to have_content('Location: the jungle')
      click_on 'Log Out'
      click_on 'Log In'

      within '.login_form' do
        expect(page).to have_field(:location, with: 'the jungle')
      end
    end
  end
end