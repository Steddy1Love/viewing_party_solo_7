require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of(:password)}
    it { should have_secure_password}
    it { should allow_value('something@something.something').for(:email) }
    it { should_not allow_value('something somthing@something.something').for(:email) }
    it { should_not allow_value('something.something@').for(:email) }
    it { should_not allow_value('something').for(:email) }

  end

  describe 'associations' do
    it { should have_many :user_parties }
    it { should have_many(:viewing_parties).through(:user_parties) }
  end

  

  describe '#instance_methods' do
    before(:each) do
      # create Users
      @user1 = User.create!(name: 'Sam', email: 'sam@email.com', password: 'hunter8')

      9.times do
        User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password)
      end

      # create Parties
      @party1 = ViewingParty.create!(duration: rand(180..240), date: Faker::Date.forward(days: rand(1..14)), start_time: Time.new.strftime("%H:%M"), movie_id: 767)
      @party2 = ViewingParty.create!(duration: rand(180..240), date: Faker::Date.forward(days: rand(1..14)), start_time: Time.new.strftime("%H:%M"), movie_id: 330459)
      @party3 = ViewingParty.create!(duration: rand(180..240), date: Faker::Date.forward(days: rand(1..14)), start_time: Time.new.strftime("%H:%M"), movie_id: 7446)
      @party4 = ViewingParty.create!(duration: rand(180..240), date: Faker::Date.forward(days: rand(1..14)), start_time: Time.new.strftime("%H:%M"), movie_id: 157336)
      @party5 = ViewingParty.create!(duration: rand(180..240), date: Faker::Date.forward(days: rand(1..14)), start_time: Time.new.strftime("%H:%M"), movie_id: 11817)
      @party6 = ViewingParty.create!(duration: rand(180..240), date: Faker::Date.forward(days: rand(1..14)), start_time: Time.new.strftime("%H:%M"), movie_id: 11817)

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

    describe '#hosted_parties' do
      it 'returns all viewing parties that the user is the host of', :vcr do
        expect(@user1.hosted_parties).to eq([@party1, @party6])
      end
    end

    describe '#guest_parties' do
      it 'returns all viewing parties that the user is a guest of', :vcr do
        expect(@user1.guest_parties).to eq([@party2, @party5])
      end
    end
  end
end