require 'rails_helper'

RSpec.describe 'Viewing Party New Page', type: :feature do
  describe 'User Story 4' do
    it 'shows the movie title over a form with fields for party duration(default value is the movies runtime and cannot be less than this), date selection, start time, guests, button to create a party',
       :vcr do
      user = User.create!(name: 'Sam', email: 'sam@email.com', password: Faker::Internet.password)
      user2 = User.create!(name: 'Mike', email: 'mike@email.com', password: Faker::Internet.password)
      user3 = User.create!(name: 'Ron', email: 'ron@email.com', password: Faker::Internet.password)
      user4 = User.create!(name: 'Angel', email: 'angel@email.com', password: Faker::Internet.password)

      visit new_user_movie_viewing_party_path(user, 767)

      expect(page).to have_button('Discover Page')

      expect(page).to have_field('Duration:', with: '153')
      fill_in(:duration, with: 180)
      fill_in(:date, with: Date.tomorrow)
      fill_in(:start_time, with: '18:00')
      fill_in(:guest_1, with: 'mike@email.com')
      fill_in(:guest_2, with: 'angel@email.com')
      click_button('Create Party')

      expect(current_path).to eq(user_path(user))
    end

    it 'creates the movie unless there are errors which will be shown when youre redirected to the new viewing party page and shows the info on the user dashboard page if successfully created',
       :vcr do
      user = User.create!(name: 'Sam', email: 'sam@email.com', password: Faker::Internet.password)
      User.create!(name: 'Mike', email: 'mike@email.com', password: Faker::Internet.password)
      User.create!(name: 'Ron', email: 'ron@email.com', password: Faker::Internet.password)
      User.create!(name: 'Angel', email: 'angel@email.com', password: Faker::Internet.password)

      visit new_user_movie_viewing_party_path(user, 767)

      fill_in('Duration:', with: 5)
      fill_in('Date:', with: Date.today)
      fill_in('Start Time:', with: '18:00')
      fill_in('Guest 1:', with: 'mike@email.com')
      fill_in('Guest 2:', with: 'angel@email.com')
      click_button('Create Party')

      expect(page).to have_content("Duration can't be shorter than movie runtime")

      expect(current_path).to eq(new_user_movie_viewing_party_path(user, 767))

      fill_in('Duration:', with: 180)
      fill_in('Date:', with: Date.tomorrow)
      fill_in('Start Time:', with: '18:00')
      fill_in('Guest 1:', with: 'mike@email.com')
      fill_in('Guest 2:', with: 'angel@email.com')
      click_button('Create Party')

      expect(current_path).to eq(user_path(user))

      expect(page).to have_content('Host: Sam')
      expect(page).to have_content('Mike')
      expect(page).to have_content('Angel')
      expect(page).to have_content("Party Time: #{Date.tomorrow} at 18:00")
    end
  end
end