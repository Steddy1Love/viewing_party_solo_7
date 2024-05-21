class MovieService
  def top_rated_movies
    get_url('movie/top_rated')[:results]
  end

  def movie_search(search)
    query = search.gsub(' ', '%20')
    get_url("search/movie?query=#{query}")[:results]
  end

  def find_movie(id)
    get_url("movie/#{id}?append_to_response=credits,reviews")
  end

  def find_movie_providers(id)
    get_url("movie/#{id}/watch/providers")[:results][:US]
  end

  def find_similar_movies(id)
    get_url("movie/#{id}/similar")[:results]
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.themoviedb.org/3/") do |faraday|
      faraday.params["api_key"] = Rails.application.credentials.tmdb[:key]
    end
  end
end