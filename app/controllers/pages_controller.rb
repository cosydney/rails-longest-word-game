require "longest_word"

class PagesController < ApplicationController

  def create
    if user = User.authenticate(params[:username], params[:password])
      # Save the user ID in the session so it can be used in
      # subsequent requests
      session[:current_user_id] = user.id
      redirect_to root_url
    end
  end

  def game
    @start_time = Time.now
    @grid = generate_grid(30)
  end

  def score
    @end_time = Time.now
    if params[:answer].nil? || params[:answer].empty?
      redirect_to game_path
    else

    @answer = params[:answer]
    @grid = params[:grid].split('')
    @start_time = params[:start_time].to_datetime
    @score = run_game(@answer, @grid, @start_time, @end_time )
    end
  end

end
