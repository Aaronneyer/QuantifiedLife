class DropboxController < ApplicationController
  def callback
    @dropbox = DropboxOAuth2Flow.new(ENV['DROPBOX_APP_KEY'],
                                     ENV['DROPBOX_APP_SECRET'])
    access_token, uid, _ = @dropbox.finish(params)
    current_user.dropbox_token = access_token
    current_user.dropbox_uid = uid
    current_user.save
    redirect_to dropbox_index_path
  end
end
