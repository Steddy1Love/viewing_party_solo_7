require 'rails_helper'

RSpec.describe 'Movies Index Page', type: :feature do
  describe 'User Story 2' do
    it 'displays each movies title as a link to the movie details page and their Vote Average', :vcr do
      user = User.create!(name: 'Sam', email: 'sam@email.com', password: Faker::Internet.password)

      visit user_discover_index_path(user)

      fill_in(:search, with: 'harry potter')
      click_button('Find Movies')

      within '#movie_list' do
        within '#movie_671_info' do
          expect(page).to have_link("Harry Potter and the Philosopher's Stone", href: user_movie_path(user, 671))
          expect(page).to have_content('Vote Average: 7.91')
        end

        within '#movie_767_info' do
          expect(page).to have_link('Harry Potter and the Half-Blood Prince', href: user_movie_path(user, 767))
          expect(page).to have_content('Vote Average: 7.69')
        end
      end
    end

    it 'displays a max of 20 movies', :vcr do
      user = User.create!(name: 'Sam', email: 'sam@email.com', password: Faker::Internet.password)

      visit user_movies_path(user)

      within '#movie_list' do
        expect(page).to have_content('Vote Average:', maximum: 20)
      end
    end

    it 'has a button to the discover page', :vcr do
      user = User.create!(name: 'Sam', email: 'sam@email.com', password: Faker::Internet.password)

      visit user_movies_path(user)

      click_button('Discover Page')

      expect(current_path).to eq(user_discover_index_path(user))
    end
  end
end