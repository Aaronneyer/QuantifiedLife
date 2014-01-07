module AuthHelper
  def moves_client
    @moves_client ||= OAuth2::Client.new(
      ENV['MOVES_ID'],
      ENV['MOVES_SECRET'],
      :site => 'https://api.moves-app.com',
      :authorize_url => '/oauth/v1/authorize',
      :token_url => '/oauth/v1/access_token')
  end

  def github_client
    @github_client ||= Github.new(client_id: ENV['GITHUB_CLIENT_ID'],
                                  client_secret: ENV['GITHUB_CLIENT_SECRET'])
  end

  def dropbox_client
    @dropbox_client ||= DropboxOAuth2Flow.new(ENV['DROPBOX_APP_KEY'],
                                              ENV['DROPBOX_APP_SECRET'],
                                              redirect_uri('dropbox'),
                                              session, :_csrf_token)
  end

  def redirect_uri(path)
    uri = URI.parse(request.url)
    uri.path = "/auth/#{path}/callback"
    uri.query = nil
    uri.to_s
  end
end
