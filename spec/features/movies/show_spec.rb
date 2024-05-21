require 'rails_helper'

RSpec.describe 'Movie Show Page', type: :feature do
  describe 'User Story 3' do
    it 'has a button to create a new viewing party', :vcr do
      user = User.create!(name: 'Sam', email: 'sam@email.com', password: Faker::Internet.password)

      visit user_movie_path(user, 767)

      click_button('Create Viewing Party for Harry Potter and the Half-Blood Prince')

      expect(current_path).to eq(new_user_movie_viewing_party_path(user, 767))
    end

    it 'has a button to return to the discover page', :vcr do
      user = User.create!(name: 'Sam', email: 'sam@email.com', password: Faker::Internet.password)

      visit user_movie_path(user, 767)

      click_button('Discover Page')

      expect(current_path).to eq(user_discover_index_path(user))
    end

    it 'shows the movies title, its vote average, it runtime in hours and minutes, its genres, its summary, its first 10 cast members, its count of total reviews and each reviews author and information',
       :vcr do
      user = User.create!(name: 'Sam', email: 'sam@email.com', password: Faker::Internet.password)

      visit user_movie_path(user, 767)

      expect(page).to have_content('Harry Potter and the Half-Blood Prince')

      summary = 'As Lord Voldemort tightens his grip on both the Muggle and wizarding worlds, Hogwarts is no longer'

      within '#movie_info' do
        expect(page).to have_content('Vote: 7.7')
        expect(page).to have_content('Runtime: 2 hr 33 min')
        expect(page).to have_content('Genre: Adventure, Fantasy')
        expect(page).to have_content(summary)

        within '#cast' do
          expect(page).to have_content('Name: Daniel Radcliffe')
          expect(page).to have_content('Character: Harry Potter')
          expect(page).to have_content('Name: Rupert Grint')
          expect(page).to have_content('Character: Ron Weasley')
          expect(page).to have_content('Name: Emma Watson')
          expect(page).to have_content('Character: Hermione Granger')

          expect(page).to have_content('Character:', maximum: 10)
        end

        review1 = 'Hormones over excitement as part six is merely an appetiser to the double billed closure to come.'
        review2 = 'Has the quality direction of _Order of the Phoenix_ but manages to separate itself from that movie'

        within '#reviews' do
          expect(page).to have_content('4 Reviews')
          expect(page).to have_content('Author: John Chard')
          expect(page).to have_content("Review: #{review1}")
          expect(page).to have_content('Author: Gimly')
          expect(page).to have_content("Review: #{review2}")
        end
      end
    end
  end

  describe 'User Story 6' do
    it 'shows a link to get similar movies and when clicked on, im taken to Similar Movies page', :vcr do
      user = User.create!(name: 'Sam', email: 'sam@email.com', password: Faker::Internet.password)

      visit user_movie_path(user, 767)

      click_link('Get Similar Movies', href: user_movie_similar_index_path(user, 767))

      expect(current_path).to eq(user_movie_similar_index_path(user, 767))
    end
  end
end