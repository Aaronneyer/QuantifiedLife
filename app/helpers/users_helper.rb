module UsersHelper
  def github_url
    if @user == current_user
      @github ||= Github.new(client_id: ENV['GITHUB_CLIENT_ID'],
                             client_secret: ENV['GITHUB_CLIENT_SECRET'])
      link_to("Link Your Github", @github.authorize_url)
    else
      "No Github Linked"
    end
  end

  def dropbox_url
    if @user == current_user
      @dropbox ||= DropboxOAuth2Flow.new(ENV['DROPBOX_APP_KEY'],
                                       ENV['DROPBOX_APP_SECRET'],
                                       'https://aaron.neyer.io/dropbox/callback',
                                       session, :_csrf_token)
      link_to("Link Your Dropbox", @dropbox.start)
    else
      "No Dropbox Linked"
    end
  end
end
