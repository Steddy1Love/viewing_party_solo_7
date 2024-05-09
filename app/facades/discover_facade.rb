class DiscoverFacade
  def movie_list
    service = ApiService.new

    json = service.movies
    binding.pry
    movies = json[:movies]
  end
end