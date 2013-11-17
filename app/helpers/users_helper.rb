module UsersHelper
  def github_url
    @github ||= Github.new(client_id: ENV['GITHUB_CLIENT_ID'],
                         client_secret: ENV['GITHUB_CLIENT_SECRET'])
    link_to("Github Auth", @github.authorize_url)
  end
end
