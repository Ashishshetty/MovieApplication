class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  def index
     # @movies = Movie.all
    # @movies = Movie.find_by_name(params[:name]) if params[:name].present?
    @movies = Movie.all.order('order_no ASC')
  end

  def new
    @movie = Movie.new
  end

  def edit
    # @movie = Movie.find(params[:id])
  end
  #
  
  def create
    @movie = Movie.new(movie_params)
  # binding.pry
    respond_to do |format|
      # if 
         @movie.save
        format.html { redirect_to movies_url, notice: 'Movie was successfully created.' }
        format.js
      #   format.json { render :show, status: :created, location: @movie }
      # else
        
      # end
    end
  end

def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Film was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def sort
    # reading
    params[:changed_orders].values.each do |param|
      #update
      @movie = Movie.find(param[:id])
      @movie.order_no = param[:order_no]
      @movie.save!
    end
      render text: 'success'
  end

  def rate
  #binding.pry
    @movie = Movie.find(params[:movie_id])
    @movie.rating = params[:ratings]
    @movie.save!
  end
  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:name, :realese, :actor, :director, :rating)
  end
  end


