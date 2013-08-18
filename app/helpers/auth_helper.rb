module AuthHelper
  def github_url
    link_to("Github Auth", @github.authorize_url(scope: "repo"))
  end
end
