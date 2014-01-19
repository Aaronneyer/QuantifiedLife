class GithubEvent::PushEvent < GithubEvent
  def info_string
    "You pushed #{pluralize(event['payload']['commits'].count, "commit")} to #{event['repo']['name']}"
  end
end
