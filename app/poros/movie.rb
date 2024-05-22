class Movie
  attr_reader :id,
              :title,
              :vote_average,
              :runtime,
              :summary,
              :cast,
              :reviews,
              :release_date,
              :poster_path

  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @vote_average = data[:vote_average]
    @runtime = data[:runtime]
    @genres = data[:genres]
    @summary = data[:summary]
    @cast = data[:cast]
    @reviews = data[:reviews]
    @release_date = data[:release_date]
    @poster_path = data[:poster_path]
  end

  def runtime_converted
    "#{@runtime / 60} hr #{@runtime % 60} min"
  end

  def genre_names
    @genres.map do |genre|
      genre[:name]
    end.join(', ')
  end

  def review_count
    @reviews.count
  end

  def top_ten_cast
    @cast[0..9]
  end
end