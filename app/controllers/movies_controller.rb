# frozen_string_literal: true

# Controller for Movie
class MoviesController < ApplicationController
  # skip_before_action :preload_data, raise: false
  before_action :set_movie, only: %i[show edit update destroy]

  def index
    if !params[:key].presence || !params[:order].presence
      if session[:key].presence
        @movies = Movie.order("#{session[:key]} #{session[:order]}")
        return
      else
        session[:key] = 'title'
        session[:order] = 'asc'
      end
    else
      session[:order] = params[:order]
      session[:key] = params[:key]
    end

    @movies = Movie.order("#{params[:key]} #{params[:order]}")
  end

  # GET /movies/1 or /movies/1.json
  def show; end

  # GET /movies/new
  def new
    @movie = Movie.new
    # session[:key] = "title"
    # session[:order] = "desc"
  end

  # GET /movies/1/edit
  def edit; end

  # POST /movies or /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to movie_url(@movie), notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to movie_url(@movie), notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy!

    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_movie
    @movie = Movie.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
