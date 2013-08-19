module GithubHelper
  def github_url
    link_to("Github Auth", @github.authorize_url)
  end
end
