class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :update, :destroy]

  # GET /movies
  def index
    @movies = Movie.all

    render json: @movies
  end

  # GET /movies/1
  def show
    render json: @movie
  end

  def seen
    movies =  Movie.where(seen: true)
    render json: movies
  end

  def notseen
    movies = Movie.where(seen: false)
    render json: movies
  end

  def favorites
    movies = Movie.where(favorite: true)
    render json: movies
  end

  # POST /movies
  def create
    if(params[:title] === "" || params[:title].nil?)
      render :json => "Error: No Title Supplied"
    else
      response = RestClient.get "http://www.omdbapi.com/?t="+ params[:title] + "&apikey=d2a6e2a0"
      data = JSON.parse(response.body)
      @movie = Movie.new(title: data["Title"], 
                         genre: data["Genre"], 
                         Rating: data["imdbRating"],
                         mc: data["Metascore"],
                         rt: data["Ratings"][1]["Value"],
                         studio: data["Production"],
                         plot: data["Plot"],
                         poster: data["Poster"],
                         seen: params[:seen],
                         favorite: params[:favorite])
      if @movie.save
        render json: @movie, status: :created, location: @movie
      else
        render json: @movie.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /movies/1
  def update
    if @movie.update(movie_params)
      render json: @movie
    else
      render json: @movie.errors
    end
  end

  # DELETE /movies/1
  def destroy
    @movie.destroy
  end

  private
    def movie_params
      params.require(:movie).permit(:title, :poster, :studio, :plot, :seen, :notseen, :favorite, :Rating, :mc, :genre, :rt)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end
end
