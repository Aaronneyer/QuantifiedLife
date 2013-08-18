class AuthController < ApplicationController
  before_action :set_github, only: %i[github github_callback]

  def github
  end

  def github_callback
    current_user.github_token = @github.get_token(params[:code]).token
    current_user.save
    redirect_to github_auth_index_path
  end

  private

  def set_github
    @github = Github.new(client_id: ENV['GITHUB_CLIENT_ID'],
                         client_secret: ENV['GITHUB_CLIENT_SECRET'])
  end
end
