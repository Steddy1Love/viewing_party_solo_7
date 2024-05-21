class Movie
  attr_reader :id,
              :title,
              :vote_average,
              :runtime,
              :genre,
              :summary

  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @vote_average = data[:vote_average]
    @runtime = data[:runtime]
    @genre = data[:genre]
    @summary = data[:summary]
    @cast = attributes[:cast]
    @reviews = attributes[:reviews]
    @release_date = attributes[:release_date]
    @poster_path = attributes[:poster_path]
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