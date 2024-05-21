require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
  before(:each) do
    # create Users
    @user1 = User.create!(name: 'Sam', email: 'sam@email.com', password: Faker::Internet.password)

    9.times do
      User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password)
    end

    # create Parties
    @party1 = ViewingParty.create!(duration: rand(180..240), date: Faker::Date.forward(days: rand(1..14)),
                                   start_time: '18:00', movie_id: 767)
    @party2 = ViewingParty.create!(duration: rand(180..240), date: Faker::Date.forward(days: rand(1..14)),
                                   start_time: '17:53', movie_id: 330_459)
    @party3 = ViewingParty.create!(duration: rand(180..240), date: Faker::Date.forward(days: rand(1..14)),
                                   start_time: '19:30', movie_id: 7446)
    @party4 = ViewingParty.create!(duration: rand(180..240), date: Faker::Date.forward(days: rand(1..14)),
                                   start_time: '11:00', movie_id: 157_336)
    @party5 = ViewingParty.create!(duration: rand(180..240), date: Faker::Date.forward(days: rand(1..14)),
                                   start_time: '20:00', movie_id: 11_817)
    @party6 = ViewingParty.create!(duration: rand(180..240), date: Faker::Date.forward(days: rand(1..14)),
                                   start_time: '19:30', movie_id: 11_817)

    # set Hosts
    UserParty.create!(viewing_party: @party1, user: @user1, host: true)
    UserParty.create!(viewing_party: @party2, user: User.second, host: true)
    UserParty.create!(viewing_party: @party3, user: User.third, host: true)
    UserParty.create!(viewing_party: @party4, user: User.fourth, host: true)
    UserParty.create!(viewing_party: @party5, user: User.fifth, host: true)
    UserParty.create!(viewing_party: @party6, user: @user1, host: true)

    # set invites
    UserParty.create!(viewing_party: @party1, user: User.second, host: false)
    UserParty.create!(viewing_party: @party1, user: User.third, host: false)
    UserParty.create!(viewing_party: @party2, user: User.fourth, host: false)
    UserParty.create!(viewing_party: @party2, user: @user1, host: false)
    UserParty.create!(viewing_party: @party5, user: User.second, host: false)
    UserParty.create!(viewing_party: @party5, user: @user1, host: false)
    UserParty.create!(viewing_party: @party5, user: User.third, host: false)
    UserParty.create!(viewing_party: @party6, user: User.third, host: false)
  end

  describe 'User Story 7' do
    it 'lists all the viewing parties that the user has been invited to with the details: movie image, movie title which links to movie show page, date and time of event, who is hosting the event and list of users invited with this users name in bold',
       :vcr do
      visit user_path(@user1)

      within '.guest_parties' do
        expect(page).to have_css('.viewing_party', count: 2)
        expect(page).to have_css('img', count: 2)

        within "#party_#{@party2.id}_info" do
          expect(page).to have_link('Rogue One: A Star Wars Story', href: user_movie_path(@user1, 330_459))
          expect(page).to have_content("Party Time: #{@party2.date} at 17:53")
          expect(page).to have_content("Host: #{User.second.name}")

          expect(page).to_not have_content('Bulletproof Monk')

          within '.party_users' do
            expect(page).to have_css('strong', text: 'Sam')
            expect(page).to have_content(User.fourth.name)

            expect(page).to_not have_content(User.third.name)
          end
        end

        within "#party_#{@party5.id}_info" do
          expect(page).to have_link('Bulletproof Monk', href: user_movie_path(@user1, 11_817))
          expect(page).to have_content("Party Time: #{@party5.date} at 20:00")
          expect(page).to have_content("Host: #{User.fifth.name}")

          expect(page).to_not have_content('Rogue One: A Star Wars Story')

          within '.party_users' do
            expect(page).to have_css('strong', text: 'Sam')
            expect(page).to have_content(User.second.name)
            expect(page).to have_content(User.third.name)

            expect(page).to_not have_content(User.fourth.name)
          end
        end
      end
    end

    it 'lists all the viewing parties that the user is hosting with the details: movie image, movie title which links to movie show page, date and time of event, who is hosting the event and list of users invited with this users name in bold',
       :vcr do
      visit user_path(@user1)

      within '.hosted_parties' do
        expect(page).to have_css('.viewing_party', count: 2)
        expect(page).to have_css('img', count: 2)

        within "#party_#{@party1.id}_info" do
          expect(page).to have_link('Harry Potter and the Half-Blood Prince', href: user_movie_path(@user1, 767))
          expect(page).to have_content("Party Time: #{@party1.date} at 18:00")
          expect(page).to have_content('Host: Sam')

          expect(page).to_not have_content('Rogue One: A Star Wars Story')

          within '.party_users' do
            expect(page).to have_content('Sam')
            expect(page).to have_content(User.second.name)
            expect(page).to have_content(User.third.name)

            expect(page).to_not have_content(User.fourth.name)
          end
        end

        within "#party_#{@party6.id}_info" do
          expect(page).to have_link('Bulletproof Monk', href: user_movie_path(@user1, 11_817))
          expect(page).to have_content("Party Time: #{@party6.date} at 19:30")
          expect(page).to have_content('Host: Sam')

          expect(page).to_not have_content('Harry Potter and the Half-Blood Prince')

          within '.party_users' do
            expect(page).to have_content('Sam')
            expect(page).to have_content(User.third.name)

            expect(page).to_not have_content(User.second.name)
          end
        end
      end
    end
  end

  it 'has a button to the discover page', :vcr do
    visit user_path(@user1)

    click_button('Discover Page')

    expect(current_path).to eq(user_discover_index_path(@user1))
  end
end