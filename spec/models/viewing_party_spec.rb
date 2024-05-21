require 'rails_helper'

RSpec.describe ViewingParty, type: :model do
  before(:each) do
      @user_1 = User.create!(name: 'Sam', email: 'sam@email.com')
      @user_2 = User.create!(name: 'Tommy', email: 'tommy@email.com')
      @party = ViewingParty.create!(date: "2023-12-01", start_time: "07:25", duration: 175)
      UserParty.create!(user_id: @user_1.id, viewing_party_id: @party.id, host: true)
      UserParty.create!(user_id: @user_2.id, viewing_party_id: @party.id, host: false)
  end
  
  describe 'relationships' do
      it { should have_many :user_parties }
      it { should have_many(:users).through(:user_parties) }
  end

  describe "instance methods" do
    it "returns user that is hosting the party" do
      expect(@party.find_host).to eq (@user_1)
    end
  end

  describe '#movie' do
    it 'returns the movie with the id equal to the movie_id if there is a movie_id', :vcr do
      party2 = ViewingParty.create!(date: '2023-12-01', start_time: '07:25', duration: 175, movie_id: 767)

      expect(@party.movie).to be nil

      expect(party2.movie).to be_a Movie
      expect(party2.movie.id).to eq(767)
    end
  end

  describe '#duration_cannot_be_less_than_movie_time' do
    it 'adds an error when creating an object if the duration is shorter than the movie runtime', :vcr do
      short_duration = 5
      party = ViewingParty.new(date: '2023-12-01', start_time: '07:25', duration: short_duration, movie_id: 767)

      expect { party.save! }.to raise_error(ActiveRecord::RecordInvalid)
      expect(party.errors[:duration]).to include("can't be shorter than movie runtime")
    end
  end
end