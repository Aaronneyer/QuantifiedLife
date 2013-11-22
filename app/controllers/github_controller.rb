class GithubController < ApplicationController
  before_action :authenticate_user!
  before_action :set_and_check_viewer, only: [:index, :backfill]

  def index
    @events = GithubEvent.where(user_id: @user.id).desc(:created_at)
  end

  def backfill
    # TODO: Replace this with one that actually backfills, potentially with
    # Bigquery
    GithubEvent.delay.backfill(@user.id.to_s)
    flash[:notice] = "We've started filling in your Github Data. Please be patient."
    redirect_to github_index_path
  end

  def callback
    @github = Github.new(client_id: ENV['GITHUB_CLIENT_ID'],
                         client_secret: ENV['GITHUB_CLIENT_SECRET'])
    current_user.update_attribute(:github_token, @github.get_token(params[:code]).token)
    redirect_to github_index_path
  end
end
