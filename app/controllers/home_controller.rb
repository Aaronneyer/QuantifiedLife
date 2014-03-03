class HomeController < ApplicationController

  impressionist actions: [:index]
  
  def index
  end

  # Used for new relic pinging
  def status
    render text: "Status: Site is up"
  end
end
