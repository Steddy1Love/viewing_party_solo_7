require 'rails_helper'

RSpec.describe 'Create New User', type: :feature do
  describe 'When user visits /register' do
    before(:each) do
      visit register_user_path
    end

    it 'has a form to fill in their name, email, password and password confirmation' do
      expect(page).to have_field(:user_name)
      expect(page).to have_field(:user_email)
      expect(page).to have_field(:user_password)
      expect(page).to have_field(:user_password_confirmation)
      expect(page).to have_selector(:link_or_button, 'Create New User')
    end

    it 'takes them to their dashboard page when they fill in the form with their name, email, password and password confirmation' do
      fill_in(:user_name, with: 'Caesar')
      fill_in(:user_email, with: 'brutus#1fan@yahoo.com')
      fill_in(:user_password, with: 'password123')
      fill_in(:user_password_confirmation, with: 'password123')
      click_button('Create New User')

      new_user = User.last

      expect(new_user.name).to eq('Caesar')
      expect(current_path).to eq(user_path(new_user))
      expect(page).to have_content('Successfully Created New User')
    end

    describe '#sad_paths' do
      it 'does something' do
        fill_in(:user_name, with: '')
        fill_in(:user_email, with: '')
        fill_in(:user_password, with: 'password123')
        fill_in(:user_password_confirmation, with: 'password')
        click_button('Create New User')

        expect(current_path).to eq(register_user_path)
        expect(page).to have_content("Name can't be blank, Email can't be blank, Email is invalid, Password confirmation doesn't match Password")
      end
    end
  end
#   describe 'When user visits "/register"' do
#     before(:each) do
#       @user1 = User.create!(name: 'Eli', email: 'eli@email.com', password: "password123")
#       @user2 = User.create!(name: 'Tov', email: 'tov@email.com', password: "password123")

#       visit register_user_path
#     end
    
#     it 'They see a Home link that redirects to landing page' do

#       expect(page).to have_link('Home')

#       click_link "Home"

#       expect(current_path).to eq(root_path)
#     end
    
#     it 'They see a form to fill in their name, email, password, and password confirmation' do
#       expect(page).to have_field("user[name]")
#       expect(page).to have_field("user[email]")
#       expect(page).to have_field("user[password]")
#       expect(page).to have_selector(:link_or_button, 'Create New User')    
#     end
    
#     it 'When they fill in the form with their name and email then they are taken to their dashboard page "/users/:id"' do
#       fill_in "user[name]", with: 'Chris'
#       fill_in "user[email]", with: 'chris@email.com'

#       click_button 'Create New User'
    
#       new_user = User.last

#       expect(current_path).to eq(user_path(new_user))
#       expect(page).to have_content('Successfully Created New User')
#     end

#     it 'when they fill in form with information, email (non-unique), submit, redirects to user show page' do
#       fill_in "user[name]", with: 'Eli'
#       fill_in "user[email]", with: 'eli@email.com'

#       click_button 'Create New User'

#       expect(current_path).to eq(register_user_path)
#       expect(page).to have_content('Email has already been taken')
#     end

#     it 'when they fill in form with missing information' do
#       fill_in "user[name]", with: ""
#       fill_in "user[email]", with: ""
#       fill_in "user[password]", with: ""
#       click_button 'Create New User'

#       expect(current_path).to eq(register_user_path)
#       expect(page).to have_content("Name can't be blank, Email can't be blank, Password can't be blank")
#     end

#     it 'They fill in form with invalid email format (only somethng@something.something)' do 
#       fill_in "user[name]", with: "Tov"
#       fill_in "user[email]", with: "tov tov@email.co.uk"
#       fill_in "user[password]", with: "password123"

#       click_button 'Create New User'

#       expect(current_path).to eq(register_user_path)
#       expect(page).to have_content('Email is invalid')

#       fill_in "user[name]", with: "Sandra"
#       fill_in "user[email]", with: "sandy@email..com"
#       fill_in "user[password]", with: "password123"
#       click_button 'Create New User'

#       expect(current_path).to eq(register_user_path)
#       expect(page).to have_content('Email is invalid')

#       fill_in "user[name]", with: "Sandra"
#       fill_in "user[email]", with: "sandy@emailcom."
#       fill_in "user[password]", with: "password123"
#       click_button 'Create New User'

#       expect(current_path).to eq(register_user_path)
#       expect(page).to have_content('Email is invalid')

#       fill_in "user[name]", with: "Sandra"
#       fill_in "user[email]", with: "sandy@emailcom@"
#       fill_in "user[password]", with: "password123"
#       click_button 'Create New User'

#       expect(current_path).to eq(register_user_path)
#       expect(page).to have_content('Email is invalid')
#     end
#   end
end