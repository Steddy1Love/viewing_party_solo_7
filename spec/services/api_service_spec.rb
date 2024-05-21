require 'rails_helper'

RSpec.describe 'Movie Service' do
  it 'exists' do
    service = MovieService.new

    expect(service).to be_a MovieService
  end

  describe '#top_rated_movies', :vcr do
    it 'returns an array of the top rated movies data' do
      movies = MovieService.new.top_rated_movies
      movie1 = movies.first
      movie2 = movies.first

      expect(movies).to be_a Array
      expect(movie1).to have_key(:title)
      expect(movie1).to have_key(:vote_average)
      expect(movie2).to have_key(:title)
      expect(movie2).to have_key(:vote_average)
    end
  end

  describe '#movie_search' do
    it 'returns an array of movies data with a title that included the searched words', :vcr do
      movies = MovieService.new.movie_search('Harry Potter')

      expect(movies).to be_a Array

      movies.each do |mov|
        expect(mov[:title]).to include('Harry Potter')
        expect(mov).to have_key(:title)
        expect(mov).to have_key(:vote_average)
      end
    end
  end

  describe '#find_movie' do
    it 'returns a hash of movie data that matches the argument id', :vcr do
      movie = MovieService.new.find_movie(767)

      expect(movie).to be_a Hash

      expect(movie).to have_key(:title)
      expect(movie[:title]).to be_a String
      expect(movie[:title]).to eq('Harry Potter and the Half-Blood Prince')

      expect(movie).to have_key(:vote_average)
      expect(movie[:vote_average]).to be_a Float

      expect(movie).to have_key(:title)
      expect(movie[:title]).to be_a String

      expect(movie).to have_key(:vote_average)
      expect(movie[:vote_average]).to be_a Float
    end
  end

  describe '#find_movie_providers' do
    it 'returns a hash where with keys to find providers who rent or let you buy the movie', :vcr do
      providers = MovieService.new.find_movie_providers(767)

      expect(providers).to be_a Hash

      expect(providers).to have_key(:buy)
      expect(providers[:buy]).to be_a Array

      expect(providers).to have_key(:rent)
      expect(providers[:rent]).to be_a Array
    end
  end

  describe '#find_similar_movies' do
    it 'returns an array of movies data that are similar to the movie with the argument ID', :vcr do
      movies = MovieService.new.find_similar_movies(767)

      expect(movies).to be_a Array

      movies.each do |mov|
        expect(mov).to have_key(:id)
        expect(mov).to have_key(:title)
        expect(mov).to have_key(:vote_average)
      end
    end
  end

  describe '#get_url', :vcr do
    it 'returns a hash of the results from the argument API call' do
      response = MovieService.new.get_url('movie/top_rated')

      expect(response).to be_a Hash

      expect(response).to have_key(:page)
      expect(response[:page]).to be_a Integer

      expect(response).to have_key(:results)
      expect(response[:results]).to be_a Array

      expect(response).to have_key(:total_pages)
      expect(response[:total_pages]).to be_a Integer

      expect(response).to have_key(:total_results)
      expect(response[:total_results]).to be_a Integer
    end
  end

  describe '#conn' do
    it 'initializes a new Faraday connection ' do
      connection = MovieService.new.conn

      expect(connection).to be_a Faraday::Connection
    end
  end
end