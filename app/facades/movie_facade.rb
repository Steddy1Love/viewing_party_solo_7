class MovieFacade
  attr_reader :movie

  def initialize(search: nil, id: nil)
    @search = search
    @id = id
    @service = MovieService.new
    @movie ||= find_movie
  end

  def find_movie
    if @id
      data = @service.find_movie(@id)

      Movie.new(format_movie_data(data))
    end
  end

  def similar_movies
    @service.find_similar_movies(@id)[0..4].map do |movie|
      data = @service.find_movie(movie[:id])

      Movie.new(format_movie_data(data))
    end
  end

  def format_movie_data(data)
    {
      id: data[:id],
      title: data[:title],
      vote_average: data[:vote_average],
      runtime: data[:runtime],
      genres: data[:genres],
      summary: data[:overview],
      cast: data[:credits][:cast],
      reviews: data[:reviews][:results],
      release_date: data[:release_date],
      poster_path: data[:poster_path]
    }
  end

  def movies
    results = (@search.nil? ? @service.top_rated_movies : @service.movie_search(@search))

    movies = results.map do |movie_data|
      Movie.new(movie_data)
    end

    movies.compact[0..19]
  end

  def movie_rental_services
    @service.find_movie_providers(@id)[:rent]
  end

  def movie_buy_services
    @service.find_movie_providers(@id)[:buy]
  end

  def images
    'https://image.tmdb.org/t/p/w200'
  end
end