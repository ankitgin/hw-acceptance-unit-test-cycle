class Movie < ActiveRecord::Base
    
    def self.same_director_movies(director)
        Movie.where(director: director)
    end
    
    
    #old code below
    def self.sorted_and_rated(ratings_list, selected_column)
  # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
    #Movie.select(:rating).distinct
  
    if ratings_list == nil or ratings_list.length == 0
        Movie.all.order(selected_column)
    else
        Movie.where(rating: ratings_list).order(selected_column)
    end
  end
  
  def self.all_ratings
      #enum all_ratings = ['G','PG','PG-13','R']
      Movie.distinct.pluck(:rating) #from ques: it's best if the controller sets this variable by consulting the Model
  end
    
end
