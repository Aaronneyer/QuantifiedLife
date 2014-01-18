class GithubEvent::GollumEvent < GithubEvent
  def info_string
    "You created/updated #{payload['pages'].count} pages"
  end
end
