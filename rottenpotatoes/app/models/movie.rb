class Movie < ActiveRecord::Base
    
    def self.same_director_movies(director)
        Movie.where(director: director)
    end
end
