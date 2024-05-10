class DiscoverFacade
  def movie_list
    service = MovieListService.new
    @movie_list = []
    json = service.movie_list
    binding.pry
    movies = json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
    @movie_list = movies.compact
  end

  def movie(id)
    service = MovieListService.new

    json = service.movie(id)
    binding.pry
    movies = json[:id].map do |movie_data|
      Movie.new(movie_data)
    end
  end
end