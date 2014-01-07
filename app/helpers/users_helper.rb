module UsersHelper
  include AuthHelper

  def github_url
    if @user == current_user
      link_to('Link Your Github', github_client.authorize_url(redirect_uri: redirect_uri('github')))
    else
      'No Github Linked'
    end
  end

  def dropbox_url
    if @user == current_user
      link_to('Link Your Dropbox', dropbox_client.start)
    else
      'No Dropbox Linked'
    end
  end

  def moves_url
    link_to('Link Moves',
            moves_client.auth_code.authorize_url(scope: 'activity location',
                                                 redirect_uri: redirect_uri('moves')))
  end
end
