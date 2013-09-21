class MovesController < ApplicationController
  def index
  end

  def new
    @moves_auth = OmniAuth::Strategies::Moves.new(ENV['MOVES_SECRET'], ENV['MOVES_ID'])
  end

  def callback
  end

  private
end
