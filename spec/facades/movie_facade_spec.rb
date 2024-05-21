require 'rails_helper'

RSpec.describe 'Movie Facade' do
  it 'exists and has no movie by default' do
    facade = MovieFacade.new

    expect(facade).to be_a MovieFacade
    expect(facade.movie).to be nil
  end

  it 'can have a movie if an ID is passed on instantiation', :vcr do
    facade = MovieFacade.new(id: 767)

    expect(facade.movie).to be_a Movie
  end

  describe '#find_movie', :vcr do
    it 'creates a movie' do
      harry_potter = MovieFacade.new(id: 767).find_movie

      expect(harry_potter).to be_a Movie
    end
  end

  describe '#movies', :vcr do
    it 'creates a list of movies' do
      facade = MovieFacade.new(search: 'harry potter')

      movies = facade.movies

      movies.each do |movie|
        expect(movie).to be_a Movie
      end
    end
  end

  describe '#similar_movies', :vcr do
    it 'creates a list of similar movies if instantiated with a movie ID' do
      facade = MovieFacade.new(id: 767)

      movies = facade.similar_movies

      movies.each do |movie|
        expect(movie).to be_a Movie
      end
    end

    describe '#movie_rental_services' do
      it 'returns a list of services where you can rent the movie if instantiated with a movie ID', :vcr do
        facade = MovieFacade.new(id: 767)

        facade.movie_rental_services.each do |service|
          expect(service).to have_key(:logo_path)
          expect(service).to have_key(:provider_name)
        end
      end
    end

    describe '#movie_buy_services' do
      it 'returns a list of services where you can buy the movie if instantiated with a movie ID', :vcr do
        facade = MovieFacade.new(id: 767)

        facade.movie_buy_services.each do |service|
          expect(service).to have_key(:logo_path)
          expect(service).to have_key(:provider_name)
        end
      end
    end

    describe '#images' do
      it 'returns a string of the URL needed to access images from the TMDB API', :vcr do
        facade = MovieFacade.new(id: 767)

        expect(facade.images).to eq('https://image.tmdb.org/t/p/w200')
      end
    end

    describe '#format_movie_data' do
      it 'formats data passed from the service into a hash that can be used to create a movie' do
        facade = MovieFacade.new

        fake_data = {
          id: nil,
          title: nil,
          vote_average: nil,
          runtime: nil,
          genres: nil,
          overview: nil,
          credits: {cast: nil},
          reviews: {results: nil},
          release_date: nil,
          poster_path: nil
        }

        expect(facade.format_movie_data(fake_data)).to have_key(:id)
        expect(facade.format_movie_data(fake_data)).to have_key(:title)
        expect(facade.format_movie_data(fake_data)).to have_key(:vote_average)
        expect(facade.format_movie_data(fake_data)).to have_key(:runtime)
        expect(facade.format_movie_data(fake_data)).to have_key(:genres)
        expect(facade.format_movie_data(fake_data)).to have_key(:summary)
        expect(facade.format_movie_data(fake_data)).to have_key(:cast)
        expect(facade.format_movie_data(fake_data)).to have_key(:reviews)
        expect(facade.format_movie_data(fake_data)).to have_key(:release_date)
        expect(facade.format_movie_data(fake_data)).to have_key(:poster_path)
      end
    end
  end
end