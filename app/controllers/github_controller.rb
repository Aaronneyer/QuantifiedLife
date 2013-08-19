class GithubController < ApplicationController
  before_action :authenticate_user!
  before_action :setup, only: %i[new callback]

  def index
    @github_events = GithubEvent.where(user_id: current_user.id)
  end

  def backfill
    # TODO: Replace this with one that actually backfills, potentially with
    # Bigquery
    User.delay.fetch_events(current_user.id)
    redirect_to github_index_path
  end

  def new
  end

  def callback
    current_user.github_token = @github.get_token(params[:code]).token
    current_user.save
    redirect_to github_index_path
  end

  private

  def setup
    @github = Github.new(client_id: ENV['GITHUB_CLIENT_ID'],
                         client_secret: ENV['GITHUB_CLIENT_SECRET'])
  end
end
