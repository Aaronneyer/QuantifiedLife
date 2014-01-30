class GithubController < ApplicationController
  before_action :authorize
  before_action :set_and_check_viewer

  def index
    @events = GithubEvent.where(user_id: @user.id).order('id DESC')
  end

  def backfill
    # TODO: Replace this with one that actually backfills, potentially with
    # Bigquery
    GithubEvent.delay.backfill(@user.id.to_s)
    flash[:notice] = "We've started filling in your Github Data. Please be patient."
    redirect_to github_index_path
  end
end
