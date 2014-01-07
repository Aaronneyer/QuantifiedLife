class CallbackController < ApplicationController
  include AuthHelper

  def moves
    token = moves_client.auth_code.get_token(params[:code], redirect_uri: redirect_uri("moves"))
    current_user.update_attribute(:moves_token, token.token)

    redirect_to user_path(current_user)
  end

  def github
    token = github_client.auth_code.get_token(params[:code])
    current_user.update_attribute(:github_token, token.token)

    redirect_to user_path(current_user)
  end

  def dropbox
    access_token, uid, _ = dropbox_client.finish(params)
    current_user.dropbox_token = access_token
    current_user.dropbox_uid = uid
    current_user.save

    redirect_to user_path(current_user)
  end
end
