class MovesController < ApplicationController
  def index
  end

  def callback
    render text: params
  end

  private
end
