class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings.keys.sort
    if params[:ratings] == nil && session[:ratings] == nil
      session[:ratings] = Movie.all_ratings
      params[:ratings] = Movie.all_ratings
      redirect_to movies_path(:sort => session[:sort], :ratings => session[:ratings])
    end

    if params[:sort] == session[:sort] && params[:ratings] == session[:ratings]
      if (params[:sort] != nil)
        @movies = Movie.where({:rating=>params[:ratings].keys}).order(params[:sort])
      else
        @movies = Movie.where({:rating=>params[:ratings].keys})
      end
    else
      if params[:sort] != nil
        session[:sort] = params[:sort]
      end
      if params[:ratings] != nil
        session[:ratings] = params[:ratings]
      end
      redirect_to movies_path(:sort => session[:sort], :ratings => session[:ratings])
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
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
