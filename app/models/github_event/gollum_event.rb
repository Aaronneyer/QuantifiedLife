class GithubEvent::GollumEvent < GithubEvent
  def info_string
    "You created/updated #{event['payload']['pages'].count} pages"
  end
end
