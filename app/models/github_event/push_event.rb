class GithubEvent::PushEvent < GithubEvent
  def info_string
    "You pushed #{pluralize(payload['commits'].count, "commit")} to #{repo['name']}"
  end
end
