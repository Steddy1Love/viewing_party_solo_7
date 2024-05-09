class ApiService
  def movies
    get_url("/3/discover/movie?limit=20")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.themoviedb.org/") do |faraday|
      faraday.headers["X-API-Key"] = Rails.application.credentials.movie[:key]
    end
  end  
end