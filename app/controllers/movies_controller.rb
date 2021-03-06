class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings=Movie.ratingcollection  
    if params[:ratings]  
      @ratings=params[:ratings].keys  
    else  
      @ratings=@all_ratings  
    end  
    @movies=Movie.where(rating: @ratings)  
  
    @sorted=0  
    @selectsort="waitparams"  
    if params[:selectsort]  
      @selectsort=params[:selectsort]  
      @movies=@movies.sort_by{|movie| movie[@selectsort]}  
      if params[:sort].to_i==1  
        @movies=@movies.reverse  
        @sorted=0  
      else  
        @sorted=1  
      end  
    end  
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

end
