require 'rails_helper'

RSpec.describe 'Discover Movies Page', type: :feature do
  describe 'User Story 1' do
    it 'has a button to discover top rated movies, a text field to enter keyword(s) to search by movie title, and a button to search by movie title',
       :vcr do
      user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: Faker::Internet.password)

      visit user_discover_index_path(user)

      expect(page).to have_button('Find Top Rated Movies')
      expect(page).to have_button('Find Movies')
      fill_in(:search, with: 'Shawshank')
      click_button('Find Movies')

      expect(current_path).to eq(user_movies_path(user))

      visit user_discover_index_path(user)

      click_button('Find Top Rated Movies')

      expect(current_path).to eq(user_movies_path(user))
    end
    # before(:each) do
    #   @user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: Faker::Internet.password)
    #   @user = User.create!(name: 'Sam', email: 'sam@email.com', password: Faker::Internet.password)

    #   visit register_user_path
    # end
  end
end