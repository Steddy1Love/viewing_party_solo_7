require "rails_helper"

RSpec.describe Movie do
  it "exists and has attrs" do
    attrs = {
      id: 201,
      title: "Star Trek: The Next Generation",
      vote_average: 7.999,
      runtime: 1000000,
      genre: "Sci-Fi",
      summary: "The next generation of Trek goers"
    }

    movie = Movie.new(attrs)

    expect(movie).to be_a(Movie)
    expect(movie.id).to eq(201)
    expect(movie.title).to eq("Star Trek: The Next Generation")
    expect(movie.vote_average).to eq(7.999)
    expect(movie.runtime).to eq(1000000)
    expect(movie.genre).to eq("Sci-Fi")
    expect(movie.summary).to eq("The next generation of Trek goers")
  end
end