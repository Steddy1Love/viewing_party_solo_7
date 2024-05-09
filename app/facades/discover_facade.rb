class DiscoverFacade
  def movie_list
    service = ApiService.new

    json = service.results
    binding.pry
    movies = json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end
end