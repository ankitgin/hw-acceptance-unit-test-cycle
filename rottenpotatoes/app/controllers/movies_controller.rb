class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #debugger
    
    if request.fullpath == "/"
      reset_session
    end
    
    @all_ratings = Movie.all_ratings
    @ratings_to_show = []
    @selected_column = session[:sort_column]
    

    if params[:ratings].present?
      session[:ratings] = params[:ratings]
      @ratings_to_show = session[:ratings].keys()
    elsif params[:home].present?
      session[:ratings] = nil
      @ratings_to_show = []
    end
      
  
    if params[:sort_column].present?
      session[:sort_column] = params[:sort_column]
      @selected_column = session[:sort_column]
    end
    
    if params[:home] == nil && session[:ratings] !=nil
      @ratings_to_show = session[:ratings].keys()
      @selected_column = session[:sort_column]
    end
      
      
    @movies = Movie.sorted_and_rated(@ratings_to_show, @selected_column)
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end


#debugger
def same_director
    
    @movie = Movie.find(params[:id])
    # debugger
    @movie_id = params[:id]
    director = @movie.director
    @director = director
    #ebugger
    if director and !director.empty?
      @movies = Movie.same_director_movies(director)
      render 'same_director_movies'
    #debugger
  else
      flash[:notice] = "'#{@movie.title}' has no director information"
      redirect_to movies_path
    end
  end


  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :director, :description, :release_date)
  end
end

