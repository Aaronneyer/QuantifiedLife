class HomeController < ApplicationController
  def index
  end

  # Used for new relic pinging
  def status
    render text: "Status: Site is up"
  end
end
