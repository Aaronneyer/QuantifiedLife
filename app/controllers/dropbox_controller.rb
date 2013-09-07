class DropboxController < ApplicationController
  before_action :setup, only: [:new, :callback]

  def index
  end

  def new
  end

  def callback
    access_token, uid, _ = @dropbox.finish(params)
    current_user.dropbox_token = access_token
    current_user.dropbox_uid = uid
    current_user.save
    redirect_to dropbox_index_path
  end

  private

  def setup
    @dropbox = DropboxOAuth2Flow.new(ENV['DROPBOX_APP_KEY'],
                                     ENV['DROPBOX_APP_SECRET'],
                                     'https://aaron.neyer.io/dropbox/callback',
                                     session, :_csrf_token)
  end
end
