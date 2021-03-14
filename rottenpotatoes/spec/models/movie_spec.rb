require 'rails_helper'

RSpec.describe Movie, type: :model do
  it "returns similar movies" do
    movie_1 = Movie.create(title: 'Dil Chahta Hai', director: 'Farhan Akhtar')
    movie_2 = Movie.create(title: 'Lakshya', director: 'Farhan Akhtar')
    movie_3 = Movie.create(title: 'Sky is Pink', director: 'Shonali Bose')
    expect(Movie.same_director_movies('Farhan Akhtar')).to eq [movie_1, movie_2]
  end
end