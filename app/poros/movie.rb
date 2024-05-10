class Movie
  attr_reader :title,
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
  end
end