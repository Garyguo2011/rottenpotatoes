class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings

    # if params[:sort] != nil
    #   session[:sort] = params[:sort]
    # end

    # if params[:ratings] == nil && session[:ratings] == nil
    #   session[:ratings] = Movie.init_ratings
    # elsif params[:ratings] != nil
    #   session[:ratings] = params[:ratings]
    # end

    # if (session[:sort] == 'title')
    #   @movies = Movie.where({:rating=>session[:ratings].keys}).order(:title)
    # elsif (session[:sort] == 'release_date')
    #   @movies = Movie.where({:rating=>session[:ratings].keys}).order(:release_date)
    # else
    #   @movies = Movie.where({:rating=>session[:ratings].keys})
    # end

    # if params[:sort] != nil && params[:sort] != session[:sort]
    #   session[:sort] = params[:sort]
    # end

    # if params[:ratings] != session[:ratings]
    #   session[:ratings] = params[ratings]
    # end


    # if params[:sort] == nil && params[:ratings] == nil && (session[:sort] != nil || session[ratings] != nil)
    #   session[:sort] = params[:sort]
    #   session[:ratings] = params[:ratings]
    #   redirect_to movies_path(:sort => session[:sort], :ratings => session[:ratings])

    # if params[:sort] == nil && params[:ratings] == nil
    #   if session[:ratings] == nil
    #     session[:ratings] = Movie.init_ratings
    #   end
    #   redirect_to movies_path(:sort => session[:sort], :ratings => session[:ratings])
    # elsif params[:sort] != nil && params[:ratings] == nil
    #   session[:sort] = params[:sort]
    #   redirect_to movies_path(session)
    # elsif params[:sort] == nil && params[:ratings] != nil
    #   session[:ratings] = params[:ratings]
    #   redirect_to movies_path(session)
    # else
    #   session[:sort] = params[:sort]
    #   session[:ratings] = params[:ratings]
    # end
    if params[:ratings] == nil && session[:ratings] == nil
      session[:ratings] = Movie.init_ratings
      params[:ratings] = Movie.init_ratings
    end

    if params[:sort] == session[:sort] && params[:ratings] == session[:ratings]
      if (params[:sort] == 'title')
        @movies = Movie.where({:rating=>params[:ratings].keys}).order(:title)
      elsif (params[:sort] == 'release_date')
        @movies = Movie.where({:rating=>params[:ratings].keys}).order(:release_date)
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
