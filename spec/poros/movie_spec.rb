require "rails_helper"

RSpec.describe Movie do
  before(:each) do
    @long_cast = [
      { name: 'Actor 1', character: 'Character 1' },
      { name: 'Actor 2', character: 'Character 2' },
      { name: 'Actor 3', character: 'Character 3' },
      { name: 'Actor 4', character: 'Character 4' },
      { name: 'Actor 5', character: 'Character 5' },
      { name: 'Actor 6', character: 'Character 6' },
      { name: 'Actor 7', character: 'Character 7' },
      { name: 'Actor 8', character: 'Character 8' },
      { name: 'Actor 9', character: 'Character 9' },
      { name: 'Actor 10', character: 'Character 10' },
      { name: 'Actor 11', character: 'Character 11' }
    ]

    attrs = {
      id: 201,
      title: "Star Trek: The Next Generation",
      vote_average: 79.999,
      cast: @long_cast,
      runtime: 118,
      genres: [{id: 1, name: 'Sci-Fi'}, {id: 2, name: "Drama"}],
      summary: "The next generation of Trek goers",
      reviews: [{author: "Author 1", content: "Best there is"}, {author: "Author 2", content: 'Over hyped!'}],
      release_date: 'January',
      poster_path: 'filename.jpg'
    }
    @movie = Movie.new(attrs)
  end
  it "exists and has attrs" do

    expect(@movie).to be_a(Movie)
    expect(@movie.id).to eq(201)
    expect(@movie.title).to eq("Star Trek: The Next Generation")
    expect(@movie.vote_average).to eq(79.999)
    expect(@movie.runtime).to eq(118)
    expect(@movie.summary).to eq("The next generation of Trek goers")
  end

  describe '#instance_methods' do
    describe '#runtime_converted' do
      it 'converts the runtime from minutes to hours and minutes' do
        expect(@movie.runtime_converted).to eq('1 hr 58 min')
      end
    end

    describe '#genre_names' do
      it 'joins the genre names together with a comma' do
        expect(@movie.genre_names).to eq('Sci-Fi, Drama')
      end
    end

    describe '#review_count' do
      it 'returns a count of the number of reviews' do
        expect(@movie.review_count).to eq(2)
      end
    end

    describe '#top_ten_cast' do
      it 'returns only the first ten cast members' do
        expect(@movie.top_ten_cast).to eq(@long_cast[0..9])
      end
    end
  end
end